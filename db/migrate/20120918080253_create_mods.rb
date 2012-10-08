class CreateMods < ActiveRecord::Migration
  def change
    create_table :mods do |t|
      t.integer :idserv
      t.integer :fkcat
      t.string :home
      t.integer :f_del
      t.integer :ordine

      t.timestamps
    end
  end
end
