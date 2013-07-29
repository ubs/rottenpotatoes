module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def hilite(column_title, sort_column)
	unless (column_title == nil || sort_column == nil)
		column_title.downcase == sort_column.downcase ? 'hilite' : 'xxx'
	end
  end
end
