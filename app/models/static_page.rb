class StaticPage < ActiveRecord::Base
  attr_accessible :foto, :url_pagina, :home_page, :f_del, :related_cat, :remove_foto
	has_many :sml, :class_name => "StaticPageSml", :foreign_key => "static_page_id"
  mount_uploader :foto, PicUploader
  mount_uploader :foto_home, PicUploader

  accepts_nested_attributes_for :sml, :allow_destroy => true

  default_scope order: 'ordine'
  
  def get_nome_pagina(id)
  	pagina = self.find(id)
  	
  	pagina.sml.where("fklang=?", "it").first.title
  end
end
