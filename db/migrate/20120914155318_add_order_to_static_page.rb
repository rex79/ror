class AddOrderToStaticPage < ActiveRecord::Migration
  def change
    add_column :static_pages, :ordine, :integer
  end
end
