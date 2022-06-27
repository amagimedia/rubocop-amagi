require 'byebug'
module RuboCop
  module Cop
    module CustomCops
      class LoggerFormatCop < Cop
        # Constant required for Rubocop
        MSG = 'Log Format should be <module/class>#method_name:<space><message>'.freeze
        def get_classname(node)
            # for getting complete names of controllers
            @name = ""
            if node.children[0] == nil
              @name += node.children[1].to_s + "::"
            else
              get_classname(node.children[0])
              @name += node.children[1].to_s + "::"
            end
            return @name[0...-2]
        end

        def on_module(node)
          # gives module name for a particular node
          @class_name = node.children[0].children[1]
        end

        def on_class(node)
          # gives class name for a particular node
          @class_name = get_classname(node.children[0])
        end

        def on_def(node)
          # gives method_name for each node
          @method_name = node.children[0]
        end

        def on_defs(node)
          # gives method_name for class methods
          @method_name = node.children[1]
        end

        def on_block(node)
          # give name of a block defined without any method
          @method_name = node.children[0].children[1].to_s if node.parent&.parent && node.parent.parent&.class_type?
        end

        def on_send(node)
          # check for info, warn, error and debug
        #   if node.children[1] == :info || node.children[1] == :warn || node.children[1] == :error || node.children[1] == :debug
            # check for Rails.logger or logger

            if node.children[1] == :puts 
              # get the logger message to compare
              
              str = get_string(node.children[2])
              # puts str
              
              if str != "#{@class_name}##{@method_name}:"
                puts @class_name
                puts @method_name
                puts "-------------------------------------------------------------"
                # add offense if format not correct
                add_offense(node, location: :expression)
              end
            end
        #   end
        end

        def get_string(node)
          string = if node&.str_type?
                     node.children[0].to_s
                   elsif node&.dstr_type?
                     node.children[0].children[0].to_s
                   else
                     'false_string'
                   end
          string.partition(' ').first
        end
      end
    end
  end
end
