class Date
	attr_accessor :year, :month, :day

	def initialize(year=nil, month=nil, day=nil)
		today = Time.new
		year.nil? ? @year = today.year : @year = year
		month.nil? ? @month = today.month : @month = month
		day.nil? ? @day = today.day : @day = day
	end

	def display
		months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
		puts "#{months[@month-1]} #{@day}, #{@year}"
	end
end

#date = Date.new(2018, 3, 8)
#puts date.display
