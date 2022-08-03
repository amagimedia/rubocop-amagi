# frozen_string_literal: true

# This cop checks if there is any "raise" code without a message/argument.
# Examples:
# Good -> raise "Message"
# Good -> raise StandardError, 'message'
# Good -> raise StandardError
#
# Bad -> raise
# Bad -> raise unless status #inline conditions with raise

module RuboCop
  module Cop
    module CustomCops
      class RaiseMessageCop < Base
        def on_send(node)
          return unless node.command?(:raise)

          # If the raise encountered does not have any arguments, add the offense
          # It ensures that raise is always accompanied with an argument.
          add_offense(node, message: 'Raise should be accompanied by a message/argument.') if node.arguments.empty?
        end
      end
    end
  end
end
