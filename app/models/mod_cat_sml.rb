class ModCatSml < ActiveRecord::Base
  attr_accessible :abstract, :description, :fklang, :fkparent, :title
  belongs_to :mod_cat
end
