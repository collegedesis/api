class University < ActiveRecord::Base
  attr_accessible :city, :name, :state, :zip
  has_many :organizations
end