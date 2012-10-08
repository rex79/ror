class AddLangToStaticPageSml < ActiveRecord::Migration
  def change
    add_column :static_page_smls, :fklang, :string
  end
end
