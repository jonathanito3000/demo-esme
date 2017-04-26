class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.references :usuario, foreign_key: true
      t.references :friend, foreign_key: true

      t.timestamps
    end
  end
end
