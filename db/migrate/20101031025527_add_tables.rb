class AddTables < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :name
      t.string :handle
      t.timestamps
    end
    
    create_table :headlines do |t|
      t.string :text
      t.integer :author_id
      t.timestamps
    end
    
    create_table :guesses do |t|
      t.integer :headline_id
      t.integer :author_id
      t.integer :user_id
      t.timestamps
    end
    
    create_table :members do |t|
      t.string :cookie_hash
      t.integer :twitter_id
      t.string :screen_name
      t.string :token
      t.string :secret
      t.string :profile_image_url
      t.timestamps
    end
  end

  def self.down
    drop_table :authors
    drop_table :headlines
  end
end
