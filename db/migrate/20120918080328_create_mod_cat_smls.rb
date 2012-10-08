class CreateModCatSmls < ActiveRecord::Migration
  def change
    create_table :mod_cat_smls do |t|
      t.integer :fkparent
      t.string :fklang
      t.string :title
      t.text :abstract
      t.text :description

      t.timestamps
    end
  end
end
