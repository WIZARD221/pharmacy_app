class Drug < ActiveRecord::Base
  has_and_belongs_to_many :stores
  								
  validates :generic_name, presence: true, length: { maximum: 50 }
  validates :form, presence: true
  validates :conditions, presence: true


  searchkick word_start: [:generic_name], autocomplete: [:generic_name]


  
  def to_s
    return "generic_name: #{self.generic_name}\nform: #{self.form}\nconditions: #{self.conditions}\nthirty_day_price: #{self.thirty_day_price}\nthirty_day_quantity: #{self.thirty_day_quantity}\nninety_day_price: #{self.ninety_day_price}\nninety_day_quantity: #{self.ninety_day_quantity}\nmedical_name: #{self.medical_name}"
  end
  
end
