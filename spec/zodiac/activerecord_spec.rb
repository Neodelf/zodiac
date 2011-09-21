# require 'spec_helper'
require 'active_record'
require 'zodiac'

class Klass < Struct.new(:dob)
  include Zodiac::ActiveRecord
end

describe Zodiac::ActiveRecord do
  before(:each) do
    Klass.zodiac_reader :dob
  end
  
  describe "class methods" do
    describe ".zodiac_reader" do
      it "sets @date_for_zodiac with the given value" do
        Klass.date_for_zodiac.should == :dob
      end
    end
  end
  
  describe "instance_methods" do
    before(:each) do
      dob = Time.gm(1967, 2, 20)
      @object = Klass.new(dob)
    end
    
    describe "#zodiac_sign" do
      it "returns a correct zodiac sign based on date_for_zodiac attribute" do
        @object.zodiac_sign.should == I18n.t('zodiac.pisces')
      end
    end
  end
  
  it "is included into ActiveRecord::Base class" do
    class ARClass < ::ActiveRecord::Base; end
    ARClass.included_modules.should include(Zodiac::ActiveRecord)
  end
end