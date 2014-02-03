class View < ActiveRecord::Base
  attr_accessible :ip, :viewable_id, :viewable_type
  belongs_to :viewable, polymorphic: true, counter_cache: true
  validates_presence_of :ip, :viewable_id, :viewable_type
end
