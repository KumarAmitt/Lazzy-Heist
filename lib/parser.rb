class Parser
  def initialize(*url)
    @url = url.join
  end

  def parsed_response
    Nokogiri::HTML(response.body)
  end

  private

  def response
    HTTParty.get(@url)
  end
end
