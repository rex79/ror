class Admin::StaticPagesController < Admin::AdminController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter {
    @lingue   = Lingue.where("active=?", "1").order("id")
  }

  def index
    @static = StaticPage.where("f_del=?", "0")
  end

  def new
    @static = StaticPage.new
    static_sml = @static.sml.build
    @lingue.each do |lang|
      @sml = {lang.cod => nil}
    end

    cats = ModCat.fetchAllCatForServizi
    @sel_cat = generateSelectFromCats cats
  end

  def create
    gen = (true && params[:static_page]) || {}
    gen['f_del'] = 0

    unless params['moduli'].nil?
      str_cat = params['moduli'].keys.join(",")
    else 
      str_cat = ""
    end
    gen['related_cat'] = str_cat

    logger.info gen.inspect

    @static = StaticPage.new(gen)
    if @static.save
      @lingue.each do |lang|
        lingua = params[lang.cod]
        lingua['fklang'] = lang.cod
        lingua['static_page_id'] = @static.id

        #@static.static_page_sml.create(lingua)
        static_sml = StaticPageSml.new(lingua)
        if static_sml.save
          flash[:notice] = "Pagina statica salvata con successo"
          redirect_to admin_static_pages_path
        else
          render 'new'
        end
      end
    end
  end

  def edit
    @static = StaticPage.find(params[:id])

    @sml = {}
    @lingue.each do |lang|
      sml_ele = @static.sml.where('fklang=? AND static_page_id=?', lang.cod, @static.id).first
      @sml = {lang.cod => sml_ele}
    end

    cats = ModCat.fetchAllCatForServizi
    @sel_cat = generateSelectFromCats cats
  end

  def update
    @static = StaticPage.find(params[:id])

    gen = (true && params[:static_page]) || {}
    gen['f_del'] = 0

    unless params['moduli'].nil?
      str_cat = params['moduli'].keys.join(",")
    else 
      str_cat = ""
    end
    gen['related_cat'] = str_cat

    if @static.update_attributes(gen)
      @lingue.each do |lang|
        lingua = params[lang.cod]
        lingua['fklang'] = lang.cod
        lingua['static_page_id'] = @static.id

        sml_mod = @static.sml.where('fklang=? AND static_page_id=?', lang.cod, @static.id).first
        if !sml_mod.nil?
          if sml_mod.update_attributes(lingua)
            flash[:notice] = 'Elemento aggiornato con successo.'
          else
            error = true
          end
        else
          sml_mod = ModulesCatSml.new(lingua)
          if sml_mod.save
            flash[:notice] = 'Elemento aggiornato con successo.'
          else
            error = true
          end
        end

        render 'edit' if error
      end
    end

    redirect_to admin_static_pages_path     
  end

  def destroy
    StaticPage.find(params[:id]).update_attributes({"f_del" => "1"})
    flash[:success] = "Pagina statica eliminata con successo."
    redirect_to admin_static_pages_path
  end

=begin
  def published
    @static = StaticPage.find(params[:id])

    if @static.published == 1
      @static.update_attributes({"published" => 0})
    else
      @static.update_attributes({"published" => 1})
    end

    redirect_to admin_static_pages_path
  end
=end

  def updateorder
    x = 1
    order_arr = params[:id].split(',')

    order_arr.each_with_index do |id, index|
      #logger.info "#{id} --> #{index}"
      order = {"ordine" => index + 1}

      mod = StaticPage.find(id.to_i)
      mod.update_attributes(order)
    end

    render :nothing => true
  end

  def addmoduli
    cats = ModCat.fetchAllCatForServizi
    @sel_cat = generateSelectFromCats cats
    @pagina = StaticPage.find(params[:id])

    render :layout => 'empty'
  end

  def savemoduli
    @pagina = StaticPage.find(params['id'])
    unless params['moduli'].nil?
      str_cat = params['moduli'].keys.join(",")
    else 
      str_cat = ""
    end

    @pagina.update_attributes({:related_cat => str_cat })
    cats = ModCat.fetchAllCatForServizi
    @sel_cat = generateSelectFromCats cats

    render 'addmoduli', :layout => 'empty'
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(admin_root_path) unless current_user?(@user)
    end

    def generateSelectFromCats(cats) 
      result = []
      cats.each do |cat|
        obj = [ cat['sml']['it'].title, cat['gen'].id ]
        result.push obj
      end

      result
    end

end
