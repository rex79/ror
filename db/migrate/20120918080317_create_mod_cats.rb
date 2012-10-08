class CreateModCats < ActiveRecord::Migration
  def change
    create_table :mod_cats do |t|
      t.integer :idserv
      t.integer :f_del
      t.integer :ordine
      t.integer :fkparent

      t.timestamps
    end
  end
end
