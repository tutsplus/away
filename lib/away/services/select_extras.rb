module Away
  class SelectExtras
    attr_reader :extras
    def initialize hotel, options = {}
      @hotel = hotel
      @in = options[:instream] || $stdin
      @out = options[:outstream] || $stdout
    end

    def start
      print_extras
      read
      select_extras
      confirm
    end

    def print_extras
      @out.print <<EOF
These are the extras for the hotel:
#{list_extras(@hotel.extras)}
Select the extras you want (separate with commas):
EOF
    end

    def list_extras extras, options = {}
      extras.map do |extra|
        id = options[:ids] === false ? "" : "[#{extra.id}] "
        "#{id}#{extra.name}"
      end.join "\n"
    end

    def read
      @extra_ids = @in.gets.chomp
    end

    def select_extras
      ids = @extra_ids.split(",").map(&:to_i)
      @extras = Extra.where(id: ids)
    end

    def confirm
      if @extras.any?
        @out.puts <<EOF
Chose the following extras:
#{list_extras @extras, ids: false}
EOF
      else
        @out.puts "You have chosen no extras. Proceed."
      end
      true
    end
  end
end
