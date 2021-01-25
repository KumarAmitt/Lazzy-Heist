class Scraper

  def initialize(parsed_content)
    @content = parsed_content
  end

  def name(css)
    parse_text(css)[0..-8]
  end

  def year(css)
    parse_text(css)[1..-2].to_i
  end

  def rating(css)
    parse_text(css).to_f
  end

  def total_reviews(css)
    parse_text(css).split(',').join.to_i
  end

  def trailer(css)
    parse_html(css)[0]['href']
  end

  private

  def parse_html(css)
    @content.css(css)
  end

  def parse_text(css)
    parse_html(css).text
  end

end
