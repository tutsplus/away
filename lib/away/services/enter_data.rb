module Away
  class EnterData
    def initialize options
      @in = options[:instream] || $stdin
      @out = options[:outstream] || $stdout
      @errors = []
    end

    def start
      @out.print "What is your name? "
      @name = @in.gets.chomp

      @out.print "Enter the credit card number: "
      @credit_card_number = @in.gets.chomp

      @out.print "Enter the credit card expiry date (yyyy/mm): "
      @credit_card_expires_at = @in.gets.chomp

      validate
      confirm
    end

    def validate
      if @name.nil? || @name.empty?
        @errors << "The name you provided is probably empty."
      end

      if @credit_card_number.empty? || @credit_card_number.gsub(/[^0-9]/, "").empty?
        @errors << "The credit card you provided is invalid."
      end

      if (@credit_card_expires_at =~ %r{[0-9]{4}/[0-9]{2}}).nil?
        @errors << "The credit card expiry date you provided is invalid."
      end
    end

    def confirm
      if @errors.any?
        @out.puts @errors.join "\n"
      else
        @out.puts <<EOF
Entered the following data:
User: #@name
Credit card number: #@credit_card_number
Credit card expiry date: #@credit_card_expires_at
EOF
      end
    end
  end
end
