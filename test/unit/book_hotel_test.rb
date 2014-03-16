require "test_helper"
require "away/services/book_hotel"

module Away
  class BookHotelTest < MiniTest::Test
    def test_books_an_hotel_room
      # setup
      @hotel = create(:hotel_with_extras, name: "Sheraton NY")
      @extras = @hotel.extras
      @data = {
        name: "Jose Mota",
        credit_card_number: "0000 0000 0000 0000",
        credit_card_expires_at: {
          year: 2015,
          month: 05
        }
      }
      @date = Time.new(2014, 12, 31)

      # operation
      service = BookHotel.new(@hotel, @extras, @data, @date)
      service.execute

      # assertions
      assert_kind_of Booking, service.booking
    end
  end
end
