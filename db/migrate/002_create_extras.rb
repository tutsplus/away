Sequel.migration do
  change do
    create_table :extras do
      primary_key :id
      String :name
      Float :price
      Integer :hotel_id
    end
  end
end
