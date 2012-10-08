class AddCatToStaticPage < ActiveRecord::Migration
  def change
    add_column :static_pages, :related_cat, :string
  end
end
