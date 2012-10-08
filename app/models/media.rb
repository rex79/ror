class Media < ActiveRecord::Base
  attr_accessible :fkfile, :fkmod

  belongs_to :mod, 		:class_name => "Mod", 		:foreign_key => "fkmod"
  belongs_to :upload, :class_name => "Upload",	:foreign_key => "fkfile"

end
