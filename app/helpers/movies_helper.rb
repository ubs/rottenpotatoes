module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def hilite(column_title, sort_column)
	unless (column_title == nil || sort_column == nil)
		column_title.downcase == sort_column.downcase ? 'hilite' : ''
	end
  end

  def get_sort_link(sort_by, filter_hash)
    movies_path(:sort_by => sort_by, :ratings => filter_hash)
  end

  def get_check_box_state(ratings_selected, rating)
	ratings_selected.include?rating
  end
end
