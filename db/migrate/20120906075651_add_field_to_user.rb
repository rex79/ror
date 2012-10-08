class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :remember_token, :string
    add_column :users, :level, :integer
    add_column :users, :active, :integer
  end
end
