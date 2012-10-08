class Admin::ServizisController < Admin::AdminController
  before_filter :signed_in_user, only: [:index, :edit, :update]

  def index
    @servizi = Servizi.where("fkparent<>?", "0")
  end

  def new
    @servizio = Servizi.new
  end

  def create
    @servizio = Servizi.new(params[:servizi])
    if @servizio.save
      flash[:notice] = "Servizio salvato con successo"
      @servizio.update_attributes({:path => "/admin/mods?idserv=#{@servizio.id}"})

      redirect_to admin_servizis_path
    else
      @servizio = Servizi.new

      render 'new'
    end
  end

  def edit
    @servizio = Servizi.find(params[:id])
  end

  def update
    @static = Servizi.find(params[:id])
    servizi = params[:servizi]
    servizi[:path] = "/admin/mods?idserv=#{@static.id}"

    if @static.update_attributes(servizi)
      flash[:notice] = 'Servizio aggiornato con successo.'
      redirect_to admin_servizis_path
    else
      @servizio = Servizi.find(params[:id])

      render 'edit'
    end
  end


  def destroy
    Servizi.find(params[:id]).destroy
    flash[:success] = "Servizio cancellato con successo."
    redirect_to admin_servizis_path
  end

  def deleteall
    del_ele = params[:id].split(',')
    del_ele.each { |ele| Servizi.find(ele).destroy }

    render :nothing => true
  end
end