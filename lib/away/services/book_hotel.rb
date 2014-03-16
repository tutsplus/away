module Away
  class BookHotel
    attr_reader :booking
    def initialize hotel, extras, data, date
      @hotel = hotel
      @extras = extras
      @data = data
      @date = date
    end

    def execute
      @booking = Booking.new booking_data
      @booking.save
    end

    def booking_data
      {
        hotel_id: @hotel.id,
        name: @data[:name],
        credit_card_number: @data[:credit_card_number],
        credit_card_expires_at: Time.new(@data[:credit_card_expires_at][:year], @data[:credit_card_expires_at][:month])
      }
    end

  end
end
