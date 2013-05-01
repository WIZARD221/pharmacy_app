class Drug < ActiveRecord::Base
  attr_accessible :generic_name, :medical_name, :form, :conditions, 
  								:thirty_day_price, :thirty_day_quantity, 
  								:ninety_day_price, :ninety_day_quantity

  validates :generic_name, presence: true, length: { maximum: 50 }
  validates :form, presence: true
  validates :conditions, presence: true
end
