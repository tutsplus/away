module Away
  class SearchHotels
    def initialize options = {}
      @in = options[:instream] || $stdin
      @out = options[:outstream] || $stdout
    end

    def start
      @out.print "Please enter a search term: "
      @term = @in.gets.chomp

      search
      render
    end

    def search
      @hotels = Hotel.where(Sequel.ilike(:name, "%#{@term}%")).all
    end

    def render
      if @hotels.any?
        @out.puts <<EOF
We found these hotels:
#{render_hotels}
EOF
        return true
      else
        @out.puts "There were no hotels that match your criteria."
        return false
      end
    end

    def render_hotels
      @hotels.map do |hotel|
        "[#{hotel.id}] #{hotel.name}"
      end.join("\n")
    end
  end
end
