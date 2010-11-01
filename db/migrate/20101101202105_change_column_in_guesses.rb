class ChangeColumnInGuesses < ActiveRecord::Migration
  def self.up
    rename_column :guesses, :user_id, :member_id
  end

  def self.down
    rename_column :guesses, :member_id, :user_id
  end
end
