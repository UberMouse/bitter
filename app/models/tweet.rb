class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :favorites

  validates :text, length: { maximum: 140}

  def get_presentation_deets
    time = created_at.strftime("%a %d %b, %I:%M%p")
    [text, user.user_name, time, id]
  end
end
