class Admin::MediaController < Admin::AdminController
	before_filter :signed_in_user

  def index
  	@upload = Upload.new
  	@all_files = Upload.all
  end

	def create
		upload = Upload.new(params[:media])
		upload.save

		render :nothing => true
	end  

  def destroy
  end

  def destroyall
  	del_ele = params[:id].split(',')
    del_ele.each do |ele| 
    	dele = Upload.find(ele)
    	dele.remove_filename!
    	dele.destroy
    end
    
    render :nothing => true
  end

end
