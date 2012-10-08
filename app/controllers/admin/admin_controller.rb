class Admin::AdminController < ActionController::Base
  include Admin::SessionsHelper

  layout 'admin'

	before_filter {
		@all_servizi = Servizi.where("enabled=? AND fkparent<>?", "1", "0")
		@lingue   = Lingue.where("active=?", "1").order("id")
	}  

  def find_by_servizio (ids) 
		Servizi.find(ids)
	end

	def sanitize_string(title)
		title.gsub(" ", "-").mb_chars.normalize(:kd).gsub(/[^\-x00-\x7F]/n, '').to_s
	end

end
