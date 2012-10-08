class HomeController < ApplicationController
	def index
		@calendar = ModCat.getDataByServizio( Servizi.find_by_nome("calendario") ) 
	end
end