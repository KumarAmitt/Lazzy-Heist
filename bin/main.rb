require 'httparty'
require 'nokogiri'
require_relative '../lib/parser'
require_relative '../lib/scraper'
require_relative '../lib/constants'

url = {
  root: 'https://www.imdb.com/',
  mv: {
    top_rated: 'chart/top/?ref_=nv_mv_250',
    popular: 'chart/moviemeter/?ref_=nv_mv_mpm'
  },
  tv: {
    top_rated: 'chart/toptv/?ref_=nv_tvv_250',
    popular: 'chart/tvmeter/?ref_=nv_tvv_mptv'
  }
}

name_css = 'div.title_bar_wrapper div.titleBar div.title_wrapper h1'
year_css = 'div.title_bar_wrapper div.titleBar div.title_wrapper h1 span#titleYear'
rating_css = 'div.title_bar_wrapper div.ratings_wrapper div.imdbRating div.ratingValue strong'
reviewers_css = 'div.title_bar_wrapper div.ratings_wrapper div.imdbRating span.small'
trailer_css = 'div.slate a'



puts '---------IMDb scraper----------'

puts '-----Top Rated movies Data-----'


top_mv_html = Parser.new(url[:root], url[:mv][:top_rated]).parsed_response


title = top_mv_html.css('td.titleColumn a')

links = []
title.each { |e| links << e['href'] }

puts links[0]

target = Parser.new(url[:root], links[0]).parsed_response

tr = Scraper.new(target)

name = tr.name(name_css)
year = tr.year(year_css)
rating = tr.rating(rating_css)
reviewers = tr.total_reviews(reviewers_css)
trailer_link = tr.trailer(trailer_css)

puts name
puts year
puts rating
puts reviewers
puts trailer_link


