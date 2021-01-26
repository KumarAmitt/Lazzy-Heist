require 'httparty'
require 'nokogiri'
require_relative '../lib/parser'
require_relative '../lib/scraper'
require_relative '../lib/constants'
require_relative '../lib/layout'


def display(idx, layout)
  puts "#{idx + 1}. Name: #{layout.name}"
  puts "   Year: #{layout.year}"
  puts "Rating: #{layout.rating}"
  puts "Reviews: #{layout.reviewers}"
  puts "Watch Trailer: #{layout.trailer_link}"

  puts "----------------------\n\n"
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
       puts 'Invalid Option'
     end

puts "\n-----Scraped Data-----\n\n"

pg1_processed = case op
                when '11'
                  Parser.new(URL[:root], URL[:mv][:top_rated]).parsed_response
                when '12'
                  Parser.new(URL[:root], URL[:mv][:popular]).parsed_response
                when '21'
                  Parser.new(URL[:root], URL[:tv][:top_rated]).parsed_response
                when '22'
                  Parser.new(URL[:root], URL[:tv][:popular]).parsed_response
                end

show_bouquet = []

pg1_filtered = pg1_processed.css(CSS_SELECTOR[:filter])
pg1_filtered.each_with_index do |e, i|
  layout = Layout.new

  layout.name_year(e)

  link_next = layout.link
  target = Parser.new(URL[:root], link_next).parsed_response
  layout.misc_info(target)

  show_bouquet << layout

  display(i, layout)

end

















