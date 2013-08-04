class Drug < ActiveRecord::Base
  has_and_belongs_to_many :stores
  
  attr_accessible :generic_name, :medical_name, :form, :conditions, 
  								:thirty_day_price, :thirty_day_quantity, 
  								:ninety_day_price, :ninety_day_quantity
  								
  validates :generic_name, presence: true, length: { maximum: 50 }
  validates :form, presence: true
  validates :conditions, presence: true
  
  def to_s
    return "generic_name: #{self.generic_name}\nform: #{self.form}\nconditions: #{self.conditions}\nthirty_day_price: #{self.thirty_day_price}\nthirty_day_quantity: #{self.thirty_day_quantity}\nninety_day_price: #{self.ninety_day_price}\nninety_day_quantity: #{self.ninety_day_quantity}\nmedical_name: #{self.medical_name}"
  end
  
end
