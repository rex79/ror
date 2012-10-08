class Servizi < ActiveRecord::Base
  attr_accessible :enabled, :fkparent, :label, :nome, :ordine, :path, :skip_cat

  validates :nome, 			presence: true
  validates :fkparent, 	presence: true
  validates :label,			presence: true
end
