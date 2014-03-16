Sequel.migration do
  change do
    create_table :hotels do
      primary_key :id
      String :name
      Integer :room_count
    end
  end
end
