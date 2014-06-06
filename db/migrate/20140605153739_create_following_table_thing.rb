class CreateFollowingTableThing < ActiveRecord::Migration
  def change
    create_table :stalker_honchos do |t|
      t.integer :stalker_id
      t.integer :honcho_id
    end

    create_table :stalkers do |t|
      t.belongs_to :user
      t.integer :stalker_id
    end

    add_index :stalkers, [:user_id, :stalker_id], :unique => true

    create_table :honchos do |t|
      t.belongs_to :user
      t.integer :honcho_id
    end

    add_index :honchos, [:user_id, :honcho_id], :unique => true
  end
end
