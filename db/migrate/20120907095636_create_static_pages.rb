class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.integer :f_del
      t.integer :published

      t.timestamps
    end
  end
end
