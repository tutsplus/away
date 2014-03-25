require "test_helper"
require "away/services/select_extras"

module Away
  class SelectExtrasTest < MiniTest::Test
    def setup
      @hotel = create :hotel, name: "Sheraton NY"
      @extras = [
        create(:extra, name: "Breakfast in Room",   hotel: @hotel),
        create(:extra, name: "Bottle of champagne", hotel: @hotel),
        create(:extra, name: "Two-Person Massage", hotel: @hotel)
      ]

      @output = StringIO.new
    end

    def test_selects_extras
      extra_ids = [ @extras[0], @extras[1] ].map(&:id).join(",")
      input = StringIO.new("#{extra_ids}\n")
      @service = SelectExtras.new @hotel, instream: input, outstream: @output
      @service.start

      expected_output = <<EOF
Chose the following extras:
#{@extras[0].name}
#{@extras[1].name}
EOF
      assert_includes @output.string, expected_output
    end

    def test_tells_the_user_if_no_extras_were_selected
      input = StringIO.new("\n")
      @service = SelectExtras.new @hotel, instream: input, outstream: @output
      @service.start

      assert_includes @output.string,
        "You have chosen no extras. Proceed."
    end
  end
end
