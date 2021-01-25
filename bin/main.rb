require 'httparty'
require 'nokogiri'

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



