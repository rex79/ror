class Admin::HomeController < Admin::AdminController
	
  def index
  	if signed_in?
  		redirect_to admin_main_path
  	end
  end
  
  def main

  end

end
