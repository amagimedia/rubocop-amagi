# frozen_string_literal: true

# This cop will checks the constant for the duplicate values in a file
# if two constants have same values it may give wrong constant name if we fetch constants using values

module RuboCop
  module Cop
    module CustomCops
      class DuplicateConstantCop < Cop

        # on every file reset the hash
        def on_new_investigation
          @occurance = {}
        end

        # on getting constant assignment
        # check if there is any constant already present with the same value
        # in that particular file
        # ignore if the const value is other than string
        # example of node on_casgn
        # (casgn nil :MILLI_SECOND
        #   (int 1000000))
        # node.children[1] consists of const name(ex: MILLI_SECOND)
        # node.children[2] consists of type and value (ex: (int 1000000))
        # node.children[2].source gives the value of the constant
        def on_casgn(node)
          const = node.children[1]
          value = node.children[2].source
          # if value is already present return error
          if @occurance[value].present?
            add_offense(node, location: :expression, message: "Duplicate value #{value} for the const #{const}. Value already present in the file as #{@occurance[value]}")
          # populate hash only if the value type string
          elsif node.children[2].str_type?
            @occurance[value] = const
          end
        end
      end
    end
  end
end
