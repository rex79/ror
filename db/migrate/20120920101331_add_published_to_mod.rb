class AddPublishedToMod < ActiveRecord::Migration
  def change
    add_column :mods, :published, :integer
  end
end
