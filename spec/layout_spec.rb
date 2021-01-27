require 'httparty'
require 'nokogiri'
require 'rspec'
require_relative '../lib/constants'
require_relative '../lib/parser'
require_relative '../lib/scraper'
require_relative '../lib/layout'

RSpec.describe Layout do
  let(:processed) { Parser.new(URL[:root], URL[:mv][:top_rated]).parsed_response }
  let(:filtered) { processed.css(CSS_SELECTOR[:filter]) }
  let(:ele) { filtered[0] }

  subject(:layout) { Layout.new }

  describe '#name_year' do
    let(:srp) { Scraper.new(ele) }
  end
end
