class Drug < ActiveRecord::Base
  has_and_belongs_to_many :stores
  
  attr_accessible :generic_name, :medical_name, :form, :conditions, 
  								:thirty_day_price, :thirty_day_quantity, 
  								:ninety_day_price, :ninety_day_quantity
  								
  validates :generic_name, presence: true, length: { maximum: 50 }
  validates :form, presence: true
  validates :conditions, presence: true
  
  # def eql?(drug)
    # differences = Array.new
#     
    # if self.generic_name != drug.generic_name
      # differences << "generic_name"
    # end
    # if self.form != drug.form
      # differences << "form"
    # end
    # if self.conditions != drug.conditions
      # differences << "conditions"
    # end
    # if self.thirty_day_price != drug.thirty_day_price
      # differences << "thirty_day_price"
    # end
    # if self.thirty_day_quantity != drug.thirty_day_quantity
      # differences << "thirty_day_quantity"
    # end
    # if self.ninety_day_price != drug.ninety_day_price
      # differences << "ninety_day_price"
    # end
    # if self.ninety_day_quantity != drug.ninety_day_quantity
      # differences << "ninety_day_quantity"
    # end
    # if self.medical_name != drug.medical_name
      # differences << "medical_name"
    # end
#     
    # return differences
  # end
  
  def to_s
    return "generic_name: #{self.generic_name}\nform: #{self.form}\nconditions: #{self.conditions}\nthirty_day_price: #{self.thirty_day_price}\nthirty_day_quantity: #{self.thirty_day_quantity}\nninety_day_price: #{self.ninety_day_price}\nninety_day_quantity: #{self.ninety_day_quantity}\nmedical_name: #{self.medical_name}"
  end
  
  
  
end
