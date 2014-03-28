module Away
  class App < Thor
    desc :book, "Books an hotel room."
    def book
      search = SearchHotels.new
      search.start || exit

      choose = ChooseHotel.new
      choose.start || exit

      select_extras = SelectExtras.new choose.hotel
      select_extras.start || exit

      enter_data = EnterData.new
      enter_data.start || exit

      book_hotel = BookHotel.new(
        choose.hotel,
        select_extras.extras,
        enter_data.data,
        Time.now
      )
      if book_hotel.execute
        puts "Hotel booked successfully."
      else
        puts "Something went wrong."
      end
    end
  end
end
