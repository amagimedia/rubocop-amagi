# frozen_string_literal: true

#This cop checks if there is any "raise" code without a message

module RuboCop
    module Cop
      module CustomCops
        class RaiseMessageCop < Base
          def on_send(node)
            return unless node.command?(:raise)
            # If the raise encountered does not have any arguments, add the offense
            # It ensures that raise is always accompanied with an argument.
            if node.arguments.size<1
              add_offense(node, message: "Raise should be accompanied with a message.")
            end
          end
        end
      end
  end
end