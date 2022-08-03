# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require 'rspec'

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense
  config.before(:suite) do
    RuboCop::Cop::Registry.global.freeze
    # This ensures that there are no side effects from running a particular spec.
    # Use `:restore_registry` / `RuboCop::Cop::Registry.with_temporary_global` if
    # need to modify registry (e.g. with `stub_cop_class`).
  end
  config.after(:suite) { RuboCop::Cop::Registry.reset! }
end
