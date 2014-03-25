require "test_helper"
require "away/services/search_hotels"

module Away
  class SearchHotelsTest < MiniTest::Test
    def setup
      create(:hotel, name: "Sheraton NY")
      create(:hotel, name: "The Grand Del Mar CA")
      create(:hotel, name: "The Bayview ME")
      @output = StringIO.new
    end

    def test_searches_for_hotels
      @input = StringIO.new("sheraton\n")

      service = SearchHotels.new instream: @input, outstream: @output
      service.start

      assert_includes @output.string, "Sheraton NY"
    end

    def test_tells_the_user_if_no_hotels_were_found
      @input = StringIO.new("BAD HOTEL\n")

      service = SearchHotels.new instream: @input, outstream: @output
      service.start

      assert_includes @output.string, "There were no hotels that match your criteria."
    end
  end
end
