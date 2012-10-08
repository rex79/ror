class Admin::SessionsController < Admin::AdminController
  def new
	end

	def create
		user = User.find_by_email_and_active(params[:session][:email], '1')
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to admin_main_path
		else
			flash[:error] = "Credenziali di accesso non valide"
			redirect_to admin_root_path
		end
	end

	def destroy
		sign_out
		flash[:notice] = "Sessione conclusa con successo"
    redirect_to admin_root_url
	end
  
end
