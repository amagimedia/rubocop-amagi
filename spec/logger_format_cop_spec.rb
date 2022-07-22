require 'spec_helper'
require_relative '../lib/cops/logger_format_cop.rb'
RSpec.describe RuboCop::Cop::CustomCops::PutLoggerFormatCop do
        context 'corrector' do
            subject(:cop) { described_class.new(config) }
            let(:config) { RuboCop::Config.new("CustomCops/PutLoggerFormatCop" => { "Enabled" => true }) }
            # let(:processed_source) {parse_source(source)}
            # let(:node) { processed_source.ast }
            it ' Log Format should be <module/class>#method_name:<space><message>
            ' do
                
                # corrector = described_class.new(processed_source.buffer)
                # pp corrector
                expect_offense(<<~RUBY)
    class A
        def B
            puts("message")
            ^^^^^^^^^^^^^^^

        end
    end
  RUBY

#   RuboCop::RSpec::ExpectOffense.expect_correction(<<~RUBY)
#     array.any?
#   RUBY
            end
        end
end