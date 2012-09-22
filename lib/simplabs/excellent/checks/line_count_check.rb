require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class LineCountCheck < Base #:nodoc:

        def initialize(interesting_contexts, threshold)
          super()
          @interesting_contexts = interesting_contexts
          @threshold            = threshold
        end

        def evaluate(context)
          add_warning(*warning_args(context)) unless context.line_count <= @threshold
        end

      end

    end

  end

end
