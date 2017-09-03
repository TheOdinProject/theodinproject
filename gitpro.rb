class Date
	attr_accessor :year, :month, :day
	@@months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

	def initialize(year=nil, month=nil, day=nil)
		today = Time.new
		year.nil? ? @year = today.year : @year = year
		month.nil? ? @month = today.month : @month = month
		day.nil? ? @day = today.day : @day = day
	end

	def display_usa
		puts "#{@@months[@month-1]} #{@day}, #{@year}"
	end

	def display_int
		puts "#{@day} #{@@months[@month-1]} #{@year}"
	end
end


#date = Date.new(2018, 3, 8)
#puts date.display_usa
#puts date.display_int
