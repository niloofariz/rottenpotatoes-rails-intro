class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    @sort = params[:sort] || session[:sort]
    case @sort
    when 'title'
      sort_by = {:title => :asc}
      @title_header = 'hilite'
    when 'release_date'
      sort_by = {:release_date => :asc}
      @release_date_header = 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @checked_ratings = params[:ratings] || session[:ratings] || {}

    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = @sort
      session[:ratings] = @checked_ratings
      flash.keep
      redirect_to :sort => @sort, :ratings => @checked_ratings and return
    end

    if @checked_ratings.empty?
      @checked_ratings = Movie.all_ratings_map
      @movies = Movie.with_ratings(@all_ratings, sort_by)
    else
      checked_ratings_keys = @checked_ratings.keys
      @movies = Movie.with_ratings(checked_ratings_keys, sort_by)
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
