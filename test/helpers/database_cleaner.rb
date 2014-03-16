module MiniTest
  class Test
    def before_setup
      DatabaseCleaner.start
    end

    def after_teardown
      DatabaseCleaner.clean
    end
  end
end
