# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/cops/raise_message_cop'
RSpec.describe RuboCop::Cop::CustomCops::RaiseMessageCop do
  context 'raise message cop' do
    subject(:cop) { described_class.new }
    it 'it should register an offense if there is an empty raise present' do
      expect_offense(<<~RUBY)
        module D
          class A
              def B
                raise
                ^^^^^ Raise should be accompanied by a message/argument.
              end
          end
        end
      RUBY
    end
    it 'it should not register an offense if raise is accompanied by an argument/message' do
      expect_no_offenses(<<~RUBY)
        module D
          class A
              def B
                raise "A message with context to the raised error."
              end
          end
        end

      RUBY

      expect_no_offenses(<<~RUBY)
        module D
          class A
              def B
                raise StandardError, 'message'
              end
          end
        end

      RUBY
    end
    it 'it should register an offense for an inline condtion' do
      expect_offense(<<~RUBY)
        module D
          class A
              def B
                raise unless status
                ^^^^^ Raise should be accompanied by a message/argument.
              end
          end
        end

      RUBY

      expect_no_offenses(<<~RUBY)
        module D
          class A
              def B
                raise StandardError, 'message' unless status
              end
          end
        end

      RUBY
    end
    it 'it should not register an offense if raise is wrapped by a rescue block' do
      expect_no_offenses(<<~RUBY)
        module D
          class A
              def B
                begin
                  this_will_fail!
                rescue Failure => error
                  log.error error.message
                  raise
                end
              end
          end
        end
      RUBY
    end
  end
end
