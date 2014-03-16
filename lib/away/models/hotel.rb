class Hotel < Sequel::Model
  one_to_many :extras
end
