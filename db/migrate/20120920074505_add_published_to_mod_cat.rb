class AddPublishedToModCat < ActiveRecord::Migration
  def change
    add_column :mod_cats, :published, :integer
  end
end
