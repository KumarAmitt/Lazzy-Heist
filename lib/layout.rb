class Layout
  attr_reader :name, :year, :link, :rating, :reviews, :trailer_link

  def name_year(ele)
    srp = Scraper.new(ele)

    @name = srp.name(CSS_SELECTOR[:title])
    @year = srp.year(CSS_SELECTOR[:year])
    @link = srp.link(CSS_SELECTOR[:title])
  end

  def misc_info(target)
    srp = Scraper.new(target)

    @rating = srp.rating(CSS_SELECTOR[:rating])
    @reviews = srp.total_reviews(CSS_SELECTOR[:reviewers])
    @trailer_link = srp.link(CSS_SELECTOR[:trailer])
    @trailer_link = @trailer_link == 1 ? 'Not Available' : URL[:root] + @trailer_link
  end

end
