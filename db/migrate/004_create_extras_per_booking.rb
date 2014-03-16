Sequel.migration do
  change do
    create_table :extras_per_booking do
      primary_key :id
      Integer :booking_id
      Integer :extra_id
    end
  end
end
