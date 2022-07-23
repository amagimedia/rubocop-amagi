require 'rubocop'
require 'rubocop/rspec/support'
require 'rspec'

RSpec.configure do |config|
   
   
  
    config.include RuboCop::RSpec::ExpectOffense
  
    config.order = :random
    Kernel.srand config.seed
  
    config.expect_with :rspec
    config.mock_with :rspec
  
    config.before(:suite) do
      RuboCop::Cop::Registry.global.freeze
      # This ensures that there are no side effects from running a particular spec.
      # Use `:restore_registry` / `RuboCop::Cop::Registry.with_temporary_global` if
      # need to modify registry (e.g. with `stub_cop_class`).
    end
  
    config.after(:suite) { RuboCop::Cop::Registry.reset! }
  
    if %w[ruby-head-ascii_spec ruby-head-spec].include? ENV.fetch('CIRCLE_JOB', nil)
      config.filter_run_excluding broken_on: :ruby_head
    end
  
    if %w[jruby-9.3-ascii_spec jruby-9.3-spec].include? ENV.fetch('CIRCLE_JOB', nil)
      config.filter_run_excluding broken_on: :jruby
    end
  end