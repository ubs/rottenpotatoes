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

  def get_check_box_state(ratings_selected, rating)
    #if (ratings_selected.has_key?rating)
    #  ratings_selected[rating][0]
    #end
    
    ratings_selected.has_key?rating
    #false
  end
end
