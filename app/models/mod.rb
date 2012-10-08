class Mod < ActiveRecord::Base
  attr_accessible :f_del, :fkcat, :home, :idserv, :ordine, :data_evento, :published
  default_scope order: 'ordine'

  has_many :sml, 		:class_name => "ModSml", :foreign_key => "fkparent"

  has_many :media,	:class_name => "Media", 	:foreign_key => "fkmod"
  has_many :upload, :through => :media

  def self.getElementByUrlTitle(url_title)
		lingue = Lingue.where("active=?", "1").order("id")
  	id_elemento = url_title.split("-").first
    elemento = Mod.find(id_elemento)

    if elemento.nil?
    	return
    else
    	result = {}
      result['gen'] = elemento
      sml = {}
      lingue.each do |lang|
        sml_ele = elemento.sml.where('fklang=? AND fkparent=?', lang.cod, elemento.id).first
        result['sml'] = {lang.cod => sml_ele}
      end
    end

    result
  end
end
