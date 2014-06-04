class Tweet < ActiveRecord::Base
  validates :text, length: { maximum: 140}
end
