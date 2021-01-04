require 'time'
require 'colorize'

def where_we_are_headed
  puts "\n\t\tWe are gallopping towards the domination of the world".red
  puts "\t\t\tAt least we made it out of 2020" if Time.now.to_i > 2020
  if Time.now.year < 2022
    puts "\n\t\tDon't be jumping for joy yet though".magenta
    puts "\t\tNostradamus has some dire predictions for #{Time.now.year}".magenta
  end
  the_end = 3797 - Time.now.year
  puts "According to the great Nostradamus we've still got #{the_end} years until the world ends".red
  puts "\tWe have a lot of time left here, it's only #{Time.now}\n".cyan
end

where_we_are_headed
