require "bundler"
Bundler.require
Bundler.require :test

ENV["APP_ENV"] = "test"

require "config"

DatabaseCleaner.strategy = :transaction
