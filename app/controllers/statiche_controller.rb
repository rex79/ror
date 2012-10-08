class StaticheController < ApplicationController
  def index  	
  	@pagina = StaticPage.find_by_url_pagina(params[:page])

  	unless @pagina.nil?
  		@pagina_sml = @pagina.sml.where("fklang=?", "it").first
  	else
  		render 'not_found'
  	end
  end
end
