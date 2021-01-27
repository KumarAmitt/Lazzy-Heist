require 'httparty'
require 'nokogiri'
require 'csv'
require_relative '../lib/parser'
require_relative '../lib/scraper'
require_relative '../lib/constants'
require_relative '../lib/layout'
require_relative '../lib/csv'


def display(idx, layout)
  print format('%-4.4s', "#{idx + 1}.")
  puts "Name    : #{layout.name}"
  puts "    Year    : #{layout.year}"
  puts "    Rating  : #{layout.rating}"
  puts "    Reviews : #{layout.reviews}"
  puts "    Trailer : #{layout.trailer_link} \n\n"
end

puts '---------IMDb Scraper----------'
puts "\nGet the list of top Movies and TV Shows"
puts "\nSelect your choice"
puts "\t1. Movies"
puts "\t2. TV Shows"
print 'Enter Your Choice: '

op = case gets.chomp.to_i
     when 1
       puts "\t1. Top Rated Movies"
       puts "\t2. Most Popular Movies"
       print 'Enter Your Choice: '
       '1' << gets.chomp
     when 2
       puts "\t1. Top Rated TV Shows"
       puts "\t2. Most Popular TV Shows"
       print 'Enter Your Choice: '
       '2' << gets.chomp
     else
       abort 'Invalid Option'
     end

begin
  processed = case op
              when '11'
                Parser.new(URL[:root], URL[:mv][:top_rated]).parsed_response
              when '12'
                Parser.new(URL[:root], URL[:mv][:popular]).parsed_response
              when '21'
                Parser.new(URL[:root], URL[:tv][:top_rated]).parsed_response
              when '22'
                Parser.new(URL[:root], URL[:tv][:popular]).parsed_response
              else
                abort 'Invalid Option'
              end
rescue StandardError
  abort 'Network unavailable! Please check your internet connection.'
end

puts "\nProcessing started..."
sleep(1)
puts 'This will take time. Please have patience.'
sleep(1)
puts "Fetching data...\n\n"


shows = []

filtered = processed.css(CSS_SELECTOR[:filter])

filtered.each_with_index do |e, i|
  layout = Layout.new

  layout.name_year(e)

  link_next = layout.link
  target = Parser.new(URL[:root], link_next).parsed_response
  layout.misc_info(target)

  shows << layout

  display(i, layout)

end

puts 'Enter y to generate csv file...'
puts 'Press Enter to exit...'
choice = gets.chomp.downcase

if choice == 'y'
  generate_csv(op, shows)
  puts 'CSV file generated successfully.'
end













