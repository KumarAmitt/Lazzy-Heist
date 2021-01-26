URL = {
  root: 'https://www.imdb.com/',
  mv: {
    top_rated: 'chart/top/?ref_=nv_mv_250',
    popular: 'chart/moviemeter/?ref_=nv_mv_mpm'
  },
  tv: {
    top_rated: 'chart/toptv/?ref_=nv_tvv_250',
    popular: 'chart/tvmeter/?ref_=nv_tvv_mptv'
  }
}.freeze

CSS_SELECTOR = {
  filter: 'td.titleColumn',
  title: 'a',
  year: 'span.secondaryInfo',
  rating: 'div.title_bar_wrapper div.ratings_wrapper div.imdbRating div.ratingValue strong',
  reviewers: 'div.title_bar_wrapper div.ratings_wrapper div.imdbRating span.small',
  trailer: 'div.slate a'
}.freeze
