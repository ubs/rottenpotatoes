class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.movie_ratings

	#params
	if (params.has_key?(:ratings))
		@ratings_selected = params[:ratings]
		@ratings_selected_keys = @ratings_selected.keys
	else
		@ratings_selected = {}
		@ratings_selected_keys = @all_ratings
	end

	@sort_column = params[:sort_by] || 'id';

	#Execute Query
	if (@ratings_selected_keys != nil)
		@movies = Movie.find(:all, :conditions => ["rating IN (?)", @ratings_selected_keys], :order => @sort_column)
	else
		@movies = Movie.find(:all, :order => @sort_column)
	end

	#@movies = Movie.order("#{@sort_column} DESC")
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
