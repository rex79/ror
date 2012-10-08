class CreateLingues < ActiveRecord::Migration
  def change
    create_table :lingues do |t|
      t.string :cod
      t.string :lingua
      t.integer :active

      t.timestamps
    end
  end
end
