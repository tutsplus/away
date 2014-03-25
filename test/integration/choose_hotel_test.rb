require "test_helper"
require "away/services/choose_hotel"

module Away
  class ChooseHotelTest < MiniTest::Test
    def setup
      @hotel = create(:hotel, name: "Sheraton NY")
      #create(:hotel, name: "The Grand Del Mar CA")
      #create(:hotel, name: "The Bayview ME")
      @output = StringIO.new
    end

    def test_chooses_a_hotel
      @input = StringIO.new("#{@hotel.id}\n")

      service = ChooseHotel.new instream: @input, outstream: @output
      service.start

      assert_includes @output.string, "Sheraton NY"
    end

    def test_tells_the_user_if_no_input
      @input = StringIO.new("\n")

      service = ChooseHotel.new instream: @input, outstream: @output
      service.start

      assert_includes @output.string, "There was a problem choosing the hotel. Check your data."
    end

    def test_tells_the_user_if_bad_input
      @input = StringIO.new("BAD ID\n")

      service = ChooseHotel.new instream: @input, outstream: @output
      service.start

      assert_includes @output.string, "There was a problem choosing the hotel. Check your data."
    end
  end
end
