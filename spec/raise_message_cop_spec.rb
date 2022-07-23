require 'spec_helper'
require_relative '../lib/cops/raise_message_cop.rb'
RSpec.describe RuboCop::Cop::CustomCops::RaiseMessageCop do
    context 'corrector' do
        subject(:cop) { described_class.new }
        it 'it should correct the node with node.children[2].children[0].class == RuboCop::AST::StrNode' do
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
    end
end