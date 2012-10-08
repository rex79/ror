class CreateStaticPageSmls < ActiveRecord::Migration
  def change
    create_table :static_page_smls do |t|
      t.string :title
      t.string :subtitle
      t.text :header
      t.text :testo
      t.text :footer

      t.timestamps
    end
  end
end
