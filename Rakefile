require "rake/testtask"

namespace :test do

  Rake::TestTask.new do |t|
    t.name = "integration"
    t.pattern = "test/integration/**/*_test.rb"
    t.libs << "test"
    t.libs << "lib"
    t.libs << "config"
  end

  Rake::TestTask.new do |t|
    t.name = "unit"
    t.pattern = "test/unit/**/*_test.rb"
    t.libs << "test"
    t.libs << "lib"
    t.libs << "config"
  end

end

task test: %w(test:unit test:integration)
task default: :test
