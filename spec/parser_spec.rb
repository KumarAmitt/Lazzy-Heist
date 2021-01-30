require 'httparty'
require 'nokogiri'
require 'rspec'
require_relative '../lib/parser'
require_relative '../lib/constants'

RSpec.describe Parser do
  subject(:parser) { Parser.new(URL[:root], URL[:mv][:popular]) }

  describe '#initialize' do
    it 'should return a complete URL appending the chunks of partial links' do
      expect(parser.instance_variable_get(:@url)).to eq(URL[:root] + URL[:mv][:popular])
    end
  end

  describe '#parsed_response' do
    it 'should generate a parsed response for the given target' do
      expect(parser.parsed_response).to match(/div/)
    end
  end
end
