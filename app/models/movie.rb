class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G','PG','PG-13','R']
  end
  def self.all_ratings_map
    {'G'=>1,'PG'=>1,'PG-13'=>1,'R'=>1}
  end
  def self.with_ratings(ratings, sort_by = nil)
    if !sort_by.nil?
      movies =  self.where(rating: ratings).order(sort_by)
    else
      movies = self.where(rating: ratings)
    end
    if movies.nil?
      movies = []
    end
    return movies
  end
end
