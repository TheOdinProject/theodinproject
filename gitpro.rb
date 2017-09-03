class Date
	def initialize(year, month, day)
		today = Time.new
		@year = year or today.year
		@month = month or today.month
		@day = day or today.day
	end
end