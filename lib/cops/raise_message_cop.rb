# frozen_string_literal: true

# This cop checks if there is any "raise" code without a message/argument.
# Examples:
# Good 
# `raise "Message"`
# `raise StandardError, 'message'`
# `raise StandardError`
#
# Bad 
# `raise`
# `raise unless status #inline conditions with raise`

module RuboCop
  module Cop
    module CustomCops
      class RaiseMessageCop < Base
        # We use #on_new_investigation instead of #initialize because #initialize is called for each class/const node
        # whereas #on_new_investigation is called at the beginning of each file and we want to maintain
        # these variables/arrays until the entire file is checked.
        #
        # @candidates  - Array to store all the possible empty nodes where an offense might occur.
        # @rescnodes  - Array to store all the rescue nodes having an empty raise as a child.
        # @finalnode  - Array to store the final nodes where offenses needed to be added.
        def on_new_investigation()
          super
          @candidates=[]
          @rescnodes=[]
          @finalnodes=[]
        end

        # This pattern matcher is used to get all the occurences of empty raises.
        def_node_matcher :empty_raise?, <<~PATTERN
          (send nil? :raise)
        PATTERN
        # This pattern matcher is used to get all the rescue nodes having an empty raise descendant.
        def_node_matcher :rescue_raises?, <<~PATTERN
          (resbody ... `(send nil? :raise))
        PATTERN

        # This is used to pickup rescue nodes wrapping empty raises.
        # The #rescue_raises? matcher will pickup only rescue nodes having empty raises and add them to @rescnodes
        def on_resbody(node)
          if rescue_raises?(node)
            puts(node)
            @rescnodes << node
          end
        end

        # This is used to pickup all the instances of empty raises.
        # The #empty_raise? matcher will pickup all the empty raises and add them to @candidates.
        def on_send(node)
          if empty_raise?(node)
            @candidates << node
          end
        end

        # We use #on_investigation_end here to add offenses after parsing the whole file.
        def on_investigation_end
          @candidates.each do |node|
            flag = true
            @rescnodes.each do |rescnode|
              if rescnode.source_range.contains?(node.source_range)
                flag = false
                break
              end
            end
            @finalnodes << node if flag
          end
          @finalnodes.each do |f|
            add_offense(f,message:"Raise should be accompanied by a message/argument.")
          end
        end
      end
    end
  end
end
