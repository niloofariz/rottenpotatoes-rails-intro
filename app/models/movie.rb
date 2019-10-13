class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G','PG','PG-13','R']
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
