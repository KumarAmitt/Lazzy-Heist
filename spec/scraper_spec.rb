require 'httparty'
require 'nokogiri'
require 'rspec'
require_relative '../lib/constants'
require_relative '../lib/parser'
require_relative '../lib/scraper'

RSpec.describe Scraper do
  subject(:scraper) { Scraper.new(Parser.new(URL[:root], URL[:mv][:popular]).parsed_response) }

  describe '#initialize' do
    it 'should assign the parsed content into an instance variable' do
      expect(scraper.instance_variable_get(:@content)).to match(/div/)
    end
  end

  describe '#name' do
    it 'should parse the name of the Movie/TV Shows' do
      expect(scraper.name('td.titleColumn a')).to include('Titanic')
    end

    it 'should not contains the movie which is not listed under the specific category' do
      expect(scraper.name('td.titleColumn a')).not_to include('Street Dancer')
    end
  end

  describe '#year' do
    it 'should parse the valid year for a movie and format it' do
      expect(scraper.year('span.secondaryInfo')).to eq(2021)
    end

    it 'should not return an invalid year' do
      expect(scraper.year('span.secondaryInfo')).to_not eq(2050)
    end
  end

  context 'To test the data originating from target(second) page' do
    let(:target) { Scraper.new(Parser.new(URL[:root], '/title/tt10451914/').parsed_response) }
    describe '#rating' do
      it 'should parse the floating point rating' do
        expect(target.rating('div.imdbRating div.ratingValue strong')).to eq(5.3)
      end

      it 'should not return invalid rating' do
        expect(target.rating('div.imdbRating div.ratingValue strong')).to_not eq('5.3')
      end
    end

    describe '#total_reviews' do
      it 'should parse the total numbers of reviews submitted' do
        expect(target.total_reviews('div.imdbRating span.small')).to eq(20_814)
      end

      it 'should not return invalid rating' do
        expect(target.rating('div.imdbRating span.small')).to_not eq('20814')
      end
    end

    describe '#link' do
      it 'should return a valid link from initial page' do
        expect(scraper.link('td.titleColumn a')).to eq('/title/tt10451914/')
      end

      it 'should return a valid link from target page' do
        expect(target.link('div.slate a')).to eq('/video/imdb/vi1057997081?playlistId=tt10451914')
      end

      it 'should return 1 if link is not available' do
        expect(target.link('div.slate a')).to_not eq(1)
      end
    end
  end
end
