require 'spec_helper'

describe Simplabs::Excellent::Checks::ModuleLineCountCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new([:ModuleLineCountCheck => { :threshold => 2 }])
  end

  describe '#evaluate' do

    it 'should accept modules with less lines than the threshold' do
      code = <<-END
        module OneLineModule; end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept modules with the same number of lines as the threshold' do
      code = <<-END
        module TwoLinesModule
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should reject modules with more lines than the threshold' do
      code = <<-END
        module FourLinesModule
          @foo = 1
          @bar = 2
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :module => 'FourLinesModule', :count => 4 }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'FourLinesModule has 4 lines.'
    end

  end

end
