class Stalker < ActiveRecord::Base
  has_many :stalker_honchos
  has_many :stalkers, through: :stalker_honchos
end