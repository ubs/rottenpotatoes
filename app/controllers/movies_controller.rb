class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end


  def index
    @all_ratings = Movie.movie_ratings

	#Filter Parameters
	if (params.has_key?(:ratings))
		@ratings_selected = params[:ratings]
		@ratings_selected_keys = @ratings_selected.keys
		
		session[:ratings] = @ratings_selected #Save Values in Session
	else
		@ratings_selected = session[:ratings]

		#if it is still empty, then use all filters as before
		if (@ratings_selected == nil)
			@ratings_selected_keys = @all_ratings
			@ratings_selected_array = @ratings_selected_keys.map { |x_rating| [x_rating, 1] }
			@ratings_selected = Hash[@ratings_selected_array]

			session[:ratings] = @ratings_selected #Save Values in Session
		else
			@ratings_selected_keys = @ratings_selected.keys
		end
	end

	#Sort Paramters
	if (params.has_key?(:sort_by))
		@sort_column = params[:sort_by] || 'id';
		session[:sort_by] = @sort_column #Save Values in Session
	else
		@sort_column = session[:sort_by];
	end

	#Check both are present or redirect as due
	if (!sort_and_filter_param_are_present?)
		if (@sort_column != nil && @ratings_selected != nil)
			@new_url = movies_path(:sort_by => @sort_column, :ratings => @ratings_selected)
			flash.keep
			redirect_to @new_url
		end
	end

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


  def sort_and_filter_param_are_present?
	(params.has_key?(:ratings) && params.has_key?(:sort_by))
  end

end
