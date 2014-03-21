require "test_helper"
require "away/services/book_hotel"

module Away
  class BookHotelTest < MiniTest::Test
    def setup
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
      @service = BookHotel.new(@hotel, @extras, @data, @date)
      @service.execute
    end

    def test_books_an_hotel_room
      assert_kind_of Booking, @service.booking
    end

    def test_shows_the_correct_information
      assert_equal "Jose Mota", @service.booking.name
    end

    def test_refers_the_correct_hotel
      assert_equal "Sheraton NY", @service.booking.hotel.name
    end

    def test_refers_to_the_correct_extras
      assert_includes @service.booking.extras.map(&:name), "My Extra"
    end

    def test_shows_the_date
      assert_equal @date, @service.booking.starts_at
    end
  end
end
