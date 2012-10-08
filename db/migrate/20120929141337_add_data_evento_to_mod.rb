class AddDataEventoToMod < ActiveRecord::Migration
  def change
    add_column :mods, :data_evento, :string
  end
end
