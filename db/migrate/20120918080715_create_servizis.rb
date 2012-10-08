class CreateServizis < ActiveRecord::Migration
  def change
    create_table :servizis do |t|
      t.integer :fkparent
      t.string :nome
      t.string :label
      t.integer :enabled
      t.integer :ordine
      t.string :path
      t.integer :skip_cat

      t.timestamps
    end
  end
end
