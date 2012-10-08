class ModCat < ActiveRecord::Base
  attr_accessible :f_del, :fkparent, :idserv, :ordine, :published

  has_many :sml,    :class_name => "ModCatSml",   :foreign_key => "fkparent"
  has_many :child,  :class_name => "Mod",         :foreign_key => "fkcat"

  def self.find_parent(id)
  	self.find(id)
  end

  def self.getCatTree(id,tree)
  	if id == 0
  		return tree
  	else
	  	cmod = ModCat.find(id)
  		tree.push({:id => cmod.id, :title => cmod.sml.where("fklang=?", "it").first.title, :idserv => cmod.idserv, :fkparent => cmod.fkparent})

  		self.getCatTree(cmod.fkparent, tree)
  	end
	end

  def self.getDataByServizio(servizio)
    lingue = Lingue.where("active=?", "1").order("id")

    if servizio.skip_cat == 1 
      # recupero gli elementi collegati alla prima categoria
      cats = self.where("idserv=? AND f_del=? AND fkparent=?", servizio.id, "0", "0").order("created_at DESC").first
      elementi = Mod.where("fkcat=? AND f_del=? AND idserv=? AND published=?", cats.id, "0", servizio.id, "1").order("created_at DESC")

      result = []
      elementi.each do |elemento|
        obj = {}
        obj['gen'] = elemento
        sml = {}
        lingue.each do |lang|
          sml_ele = elemento.sml.where('fklang=? AND fkparent=?', lang.cod, elemento.id).first
          obj['sml'] = {lang.cod => sml_ele}
        end

        result.push(obj)
      end

      result
    else
      # recupero solo le categorie
    end
  end

  def self.getDataByCat(categoria)
    lingue = Lingue.where("active=?", "1").order("id")

    # recupero gli elementi collegati alla prima categoria
    elementi = Mod.where("fkcat=? AND f_del=? AND idserv=? AND published=?", categoria.id, "0", categoria.idserv, "1").order("created_at DESC")

    result = []
    elementi.each do |elemento|
      obj = {}
      obj['gen'] = elemento
      sml = {}
      lingue.each do |lang|
        sml_ele = elemento.sml.where('fklang=? AND fkparent=?', lang.cod, elemento.id).first
        obj['sml'] = {lang.cod => sml_ele}
      end

      result.push(obj)
    end

    result
  end

  def self.fetchAllCatForServizi
    servizi = Servizi.where("enabled=? AND fkparent<>?", "1", "0")
    lingue = Lingue.where("active=?", "1").order("id")

    result = []
    cats = nil
    servizi.each do |servizio|
      if servizio.skip_cat == 1 
        # recupero informazioni per i servizi di cui non devo recuperare le sottocategorie
        cats = self.where("idserv=? AND f_del=? AND fkparent=?", servizio.id, "0", "0").order("created_at DESC")
      else 
        # recupero informazioni per i servizi di cui devo recuperare le sottocategorie
        cats = self.where("idserv=? AND f_del=?", servizio.id, "0").order("created_at DESC")
      end

      cats.each do |cat|
        obj = {}
        obj['gen'] = cat
        lingue.each do |lang|
          obj['sml'] = { lang.cod => cat.sml.where("fklang=? AND fkparent=?", "it", cat.id).first }
        end

        result.push obj
      end
    end
   

    result
  end
end
