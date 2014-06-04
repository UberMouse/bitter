class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.belongs_to :user
      t.integer :retweet_id
      t.timestamps
    end
  end
end
