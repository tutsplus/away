Sequel.connect "sqlite://db/#{ENV["APP_ENV"] || "development"}.sqlite3"
