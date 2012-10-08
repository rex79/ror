class AddStaticPageIdToStaticPageSml < ActiveRecord::Migration
  def change
    add_column :static_page_smls, :static_page_id, :integer
  end
end
