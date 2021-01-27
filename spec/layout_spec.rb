require 'httparty'
require 'nokogiri'
require 'rspec'
require_relative '../lib/constants'
require_relative '../lib/parser'
require_relative '../lib/scraper'
require_relative '../lib/layout'

RSpec.describe Layout do

  describe '#name_year' do
    processed = Parser.new(URL[:root], URL[:mv][:popular]).parsed_response
    ele = processed.css('td.titleColumn')[0]
    layout = Layout.new
    layout.name_year(ele)

    it 'should parse the name from given XML' do
      expect(layout.instance_variable_get(:@name)).to eq('Outside the Wire')
    end

    it 'should parse the year from given XML' do
      expect(layout.instance_variable_get(:@year)).to eq(2021)
    end

    it 'should parse the url from given XML' do
      expect(layout.instance_variable_get(:@link)).to eq('/title/tt10451914/')
    end
  end

  describe '#misc_info' do
    processed = Parser.new(URL[:root], '/title/tt10451914/').parsed_response
    layout = Layout.new
    layout.misc_info(processed)

    it 'should parse the rating from given XML' do
      expect(layout.instance_variable_get(:@rating)).to eq(5.3)
    end

    it 'should parse the total reviews submitted from given XML' do
      expect(layout.instance_variable_get(:@reviews)).to eq(20_937)
    end

    it 'should parse the url of trailer from given XML' do
      expect(layout.instance_variable_get(:@trailer_link)).to eq('https://www.imdb.com//video/imdb/vi1057997081?playlistId=tt10451914')
    end
  end

end
