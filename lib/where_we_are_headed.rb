require 'time'

def where_we_are_headed
  puts 'We are gallopping towards the domination of the world'
  puts 'At least we made it out of 2020' if Time.now.to_i > 2020
  if Time.now.year < 2022
    puts "Don't be jumping for joy yet though"
    puts "Nostradamus has some dire predictions for #{Time.now.year}"
  end
  the_end = 3797 - Time.now.year
  puts "According to the great Nostradamus we've still got #{the_end} years until the world ends"
  puts "Let's hope we are living under this same deep state until then"
  puts Time.now
end

where_we_are_headed
