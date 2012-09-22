require 'simplabs/excellent/checks/flog_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports blocks with a Flog metric score that is higher than the threshold. The Flog metric is very similar to the cyclomatic complexity
      # measure but also takes Ruby specific statements into account. For example, calls to metaprogramming methods such as +define_method+ or
      # +class_eval+ are weighted higher than regular method calls.
      #
      # Excellent does not calculate the score exactly the same way as Flog does, so scores may vary. For Flog also see
      # http://github.com/seattlerb/flog.
      #
      # ==== Applies to
      #
      # * blocks
      class FlogBlockCheck < FlogCheck

        DEFAULT_THRESHOLD = 15

        def initialize(options = {}) #:nodoc:
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([Parsing::BlockContext], threshold)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, '{{block}} has flog score of {{score}}.', { :block => context.full_name, :score => context.flog_score }]
          end

      end

    end

  end

end
