require 'rubocop'
require 'rubocop/rspec/support'
require 'rspec'

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense
end