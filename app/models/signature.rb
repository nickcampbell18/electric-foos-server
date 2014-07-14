class Signature < ActiveRecord::Base

  belongs_to :player

  validates_uniqueness_of :sig

end
