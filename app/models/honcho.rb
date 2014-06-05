class Honcho < ActiveRecord::Base
  has_many :stalker_honchos
  has_many :honchos, through: :stalker_honchos
end