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

        def_node_matcher :emptyraise?, <<~PATTERN
        (send nil? :raise)
        PATTERN
        def on_new_investigation()
          super
          @candidates=[] #candidates
          @rescnodes=[] #rescuenodes
          @safenodes=[] #evaluated
          @finalnodes=[]
        end

        def on_rescue(node)
          @rescnodes << node
        end

        def on_send(node)
          if emptyraise?(node)
            @candidates << node
          end
        end

        def on_investigation_end
          @rescnodes.each do |rescnode|
            @candidates.each do |node|
              if rescnode.source_range.contains?(node.source_range)
                @safenodes << node
              end
            end
          end
          @candidates.each do |n|
            @finalnodes << n if (@safenodes.select{|s| s.object_id== n.object_id}).empty?
          end
          @finalnodes.each do |f|
            add_offense(f,message:"Raise should be accompanied by a message/argument.")
          end
        end
      end
    end
  end
end
