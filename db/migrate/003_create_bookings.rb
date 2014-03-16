Sequel.migration do
  change do
    create_table :bookings do
      primary_key :id
      Integer :hotel_id
      Time :starts_at
      String :name
      String :credit_card_number
      Time :credit_card_expires_at
    end
  end
end
