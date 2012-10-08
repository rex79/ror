class AddFieldToStaticPage < ActiveRecord::Migration
  def change
    add_column :static_pages, :foto, :string
    add_column :static_pages, :foto_home, :string
    add_column :static_pages, :url_pagina, :string
    add_column :static_pages, :home_page, :integer
  end
end
