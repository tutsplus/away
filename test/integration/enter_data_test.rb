require "test_helper"
require "away/services/enter_data"

module Away
  class EnterDataTest < MiniTest::Test
    def setup
      @name = "Jose Mota"
      @credit_card_number = "0000 0000 0000 0000"
      @credit_card_expires_at = "2015/04"

      @output = StringIO.new
    end

    def test_allows_for_data_to_be_entered
      data = [
        @name,
        @credit_card_number,
        @credit_card_expires_at
      ].map { |item| "#{item}\n" }.join

      input = StringIO.new(data)

      service = EnterData.new instream: input, outstream: @output
      service.start

      assert_includes @output.string, <<EOF
Entered the following data:
User: #@name
Credit card number: #@credit_card_number
Credit card expiry date: #@credit_card_expires_at
EOF
    end

    def test_tells_the_user_if_entered_no_name
      input = StringIO.new("\nIrrelevant\nIrrelevant\n")
      @service = EnterData.new instream: input, outstream: @output
      @service.start

      assert_includes @output.string,
        "The name you provided is probably empty."
    end

    def test_tells_the_user_if_entered_bad_credit_card
      input = StringIO.new("#@name\nBAD\nIrrelevant\n")
      @service = EnterData.new instream: input, outstream: @output
      @service.start

      assert_includes @output.string,
        "The credit card you provided is invalid."
    end

    def test_tells_the_user_if_entered_bad_date
      input = StringIO.new("#@name\n#@credit_card_number\nBAD\n")
      @service = EnterData.new instream: input, outstream: @output
      @service.start

      assert_includes @output.string,
        "The credit card expiry date you provided is invalid."
    end
  end
end
