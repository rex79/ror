class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :fkfile
      t.integer :fkmod

      t.timestamps
    end
  end
end
