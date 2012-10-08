class CreateModSmls < ActiveRecord::Migration
  def change
    create_table :mod_smls do |t|
      t.integer :fkparent
      t.string :fklang
      t.string :url_title
      t.string :title
      t.text :abstract
      t.text :description

      t.timestamps
    end
  end
end
