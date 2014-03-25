module Away
  class ChooseHotel
    def initialize options
      @in = options[:instream] || $stdin
      @out = options[:outstream] || $stdout
    end

    def start
      @out.print "Please enter the id of your choice: "
      @id = @in.gets.chomp
      choose
      render
    end

    def choose
      @hotel = Hotel[@id]
    end

    def render
      if @hotel.nil?
        @out.puts "There was a problem choosing the hotel. Check your data."
      else
        @out.puts <<EOF
You have selected the hotel: #{@hotel.name}.
EOF
      end
    end
  end
end
