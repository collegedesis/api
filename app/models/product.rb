class Product < ActiveRecord::Base
  attr_accessible :name, :price
  has_many :purchases

  def to_param
    "#{id} #{name.parameterize}"
  end

  # !!!
  # Put this percentage in a constant
  # or as an attribute on the record
  def beneficiary_payout
    (self.price) * 0.3
  end
end
