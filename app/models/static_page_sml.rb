require 'carrierwave/orm/activerecord'

class StaticPageSml < ActiveRecord::Base
  attr_accessible :published, :testo, :title, :fklang, :static_page_id
end
