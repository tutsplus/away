class Booking < Sequel::Model
  many_to_one :hotel
  many_to_many :extras, join_table: :extras_per_booking
end
