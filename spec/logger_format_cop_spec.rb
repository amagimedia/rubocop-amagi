require 'spec_helper'
require_relative '../lib/cops/logger_format_cop.rb'
RSpec.describe RuboCop::Cop::CustomCops::PutLoggerFormatCop do
    context 'corrector' do
        subject(:cop) { described_class.new }
        it 'it should correct the node with node.children[2].children[0].class == RuboCop::AST::StrNode' do
            expect_offense(<<~RUBY)
              module D
                class A
                    def B
                      puts("message #{12}")
                      ^^^^^^^^^^^^^^^^^^ Log Format should be <module/class>#method_name:<space><message>
                    end
                end
              end
            RUBY
            expect_correction(<<~RUBY)
            module D
              class A
                  def B
                    puts("A#B: message 12")
                  end
              end
            end
            RUBY
        end
        it 'it should correct the node with node.children[2].children[0].class == String' do
            expect_offense(<<~RUBY)
              module D
                class A
                    def B
                      puts("message")
                      ^^^^^^^^^^^^^^^ Log Format should be <module/class>#method_name:<space><message>
                    end
                end
              end
            RUBY
            expect_correction(<<~RUBY)
            module D
              class A
                  def B
                    puts("A#B: message")
                  end
              end
            end
            RUBY
        end
    end
end