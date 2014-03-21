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
      save
    end

    private

    def save
      add_extras if @booking.save
    end

    def add_extras
      @extras.each do |extra|
        @booking.add_extra extra
      end
    end

    def booking_data
      @data.merge({
        starts_at: @date,
        hotel_id: @hotel.id,
        credit_card_expires_at: credit_card_expires_at
      })
    end

    def credit_card_expires_at
      date = @data[:credit_card_expires_at]
      Time.new date[:year], date[:month]
    end

  end
end
