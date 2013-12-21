require 'spec_helper'

describe Drug do
  
  before :each do
    @drug = Drug.new
    @drug.generic_name = "Drugy"
    @drug.medical_name = "Crazebutamol"
    @drug.conditions = "Craziness"
    @drug.form = "Syrup"
    @drug.thirty_day_price = "4"
    @drug.ninety_day_price = "10"
    @drug.thirty_day_quantity = "30"
    @drug.ninety_day_quantity = "90"
  end
  
  describe "#new" do
    it "take 8 parameters and returns a Drug object" do
      @drug.should be_an_instance_of Drug
    end
  end
  
  describe "#generic_name" do
    it "returns the correct generic name" do
      @drug.generic_name == "Drugy"
    end
  end
  
end
