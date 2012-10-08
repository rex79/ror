class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :fkfolder
      t.string :filename
      t.string :ext
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
  end
end
