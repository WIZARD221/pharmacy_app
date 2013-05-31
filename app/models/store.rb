class Store < ActiveRecord::Base
  has_and_belongs_to_many :drugs
  
  attr_accessible :name
  
  validates :name, presence: true, uniqueness: true
end
