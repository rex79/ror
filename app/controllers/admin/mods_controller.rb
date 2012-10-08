class Admin::ModsController < Admin::AdminController
  before_filter :signed_in_user, only: [:index, :edit, :update]

  ##############################################################################
  # 
  #                    SEZIONE CATEGORIE/SOTTOCATEGORIE
  #
  ##############################################################################

  def index
    @servizio = find_by_servizio params[:idserv]
    if params[:idp].nil? or params[:idp].eql?("0")
      @modules_cat = ModCat.joins(:sml).where("idserv=? AND fklang=? AND f_del='0' AND mod_cats.fkparent=?", params[:idserv], "it", "0").order("ordine")
      @id_parent = 0
    else 
      @modules_cat = ModCat.joins(:sml).where("idserv=? AND mod_cats.fkparent=? AND fklang=? AND f_del='0'", params[:idserv], params[:idp], "it").order("ordine")

      @categoria = ModCat.find(params[:idp])
      @id_parent = @categoria.id
    end
  end

  def addcat
    @servizio = find_by_servizio params[:idserv]
    @id_parent = params[:idp]

    @mod = ModCat.new
    mod_sml = @mod.sml.build
    @lingue.each do |lang|
      @sml = {lang.cod => nil}
    end
  end

  def createcat
    gen = (true && params[:mods]) || {}

    gen['f_del'] = 0

    @modcat = ModCat.new(gen)
    if @modcat.save
      @lingue.each do |lang|
        lingua = params[lang.cod]
        lingua['fklang'] = lang.cod
        lingua['fkparent'] = @modcat.id

        #@static.static_page_sml.create(lingua)
        mod_sml = ModCatSml.new(lingua)
        if mod_sml.save
          flash[:notice] = "Categoria salvata con successo"
          redirect_to "/admin/mods?idserv=#{@modcat.idserv}&idp=#{@modcat.fkparent}"
        else
          render 'new'
        end
      end
    end
  end

  def editcat
    @servizio = find_by_servizio params[:idserv]
    @mod = ModCat.find(params[:id])
    @id_parent = @mod.fkparent
    @sml = {}
    @lingue.each do |lang|
      sml_ele = @mod.sml.where('fklang=? AND fkparent=?', lang.cod, @mod.id).first
      @sml = {lang.cod => sml_ele}
    end
  end    
  
    
  def updatecat
    @mod = ModCat.find(params[:id])

    gen = (true && params[:mods]) || {}
    gen['f_del'] = 0

    if @mod.update_attributes(gen)
      @lingue.each do |lang|
        lingua = params[lang.cod]
        lingua['fklang'] = lang.cod
        lingua['fkparent'] = @mod.id

        sml_mod = @mod.sml.where('fklang=? AND fkparent=?', lang.cod, @mod.id).first
        if !sml_mod.nil?
          if sml_mod.update_attributes(lingua)
            flash[:notice] = 'Elemento aggiornato con successo.'
          else
            error = true
          end
        else
          sml_mod = ModCatSml.new(lingua)
          if sml_mod.save
            flash[:notice] = 'Elemento aggiornato con successo.'
          else
            error = true
          end
        end

        render 'edit' if error
      end
    end

    redirect_to "/admin/mods?idserv=#{@mod.idserv}&idp=#{@mod.fkparent}"
  end


  def destroycat
    mod_cat = ModCat.find(params[:id])
    mod_cat.update_attributes({"f_del" => "1"})
    flash[:success] = "Categoria eliminata con successo."
    redirect_to "/admin/mods?idserv=#{params[:idserv]}&idp=#{mod_cat.fkparent}"
  end

  def deleteallcat
    del_ele = params[:id].split(',')
    del_ele.each { |ele| ModCat.find(ele).update_attributes({"f_del" => "1"}) }

    render :nothing => true
  end

  def publishedcat
    mod_cat = ModCat.find(params[:id])

    if mod_cat.published == 1
      mod_cat.update_attributes({"published" => 0})
    else
      mod_cat.update_attributes({"published" => 1})
    end

    redirect_to "/admin/mods?idserv=#{params[:idserv]}&idp=#{mod_cat.fkparent}"
  end

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


  ##############################################################################
  # 
  #                    SEZIONE FOGLIE
  #
  ##############################################################################

  def list
    @servizio = find_by_servizio params[:idserv]
    @modules  = Mod.where("idserv=? AND fkcat=? AND f_del='0'", params[:idserv], params[:idc]).order("ordine")
    @cat      = ModCat.find(params[:idc])
  end

  def addele
    @servizio = find_by_servizio params[:idserv]
    @cat      = ModCat.find(params[:idp])
    @upload   = Upload.all

    # read the configuration file for the fields
    @fields = YAML.load( File.open("#{Rails.root}/app/admin/configs/#{@servizio.nome}.yml") )

    @mod = Mod.new
    mod_sml = @mod.sml.build
    @lingue.each do |lang|
      @sml = {lang.cod => nil}
    end
  end

  def createele
    gen = (true && params[:mods]) || {}
    gen['f_del'] = 0

    @mod = Mod.new(gen)
    if @mod.save
      @lingue.each do |lang|
        lingua = params[lang.cod]
        lingua['fklang'] = lang.cod
        lingua['fkparent'] = @mod.id
        lingua['url_title'] = URI.escape(lingua['title'].gsub(" ", "-"))

        mod_sml = ModSml.new(lingua)
        if mod_sml.save
          flash[:notice] = "Elemento salvato con successo"
          redirect_to "/admin/mods/editele?idserv=#{@mod.idserv}&idc=#{@mod.fkcat}&id=#{@mod.id}"
        else
          render 'new'
        end
      end
    end
  end

  def editele
    @servizio = find_by_servizio params[:idserv]
    @cat = ModCat.find(params[:idc])
    @upload   = Upload.all

    # read the configuration file for the fields
    @fields = YAML.load( File.open("#{Rails.root}/app/admin/configs/#{@servizio.nome}.yml") )

    @ele = Mod.find(params[:id])    
    @sml = {}
    @lingue.each do |lang|
      sml_ele = @ele.sml.where('fklang=? AND fkparent=?', lang.cod, @ele.id).first
      @sml = {lang.cod => sml_ele}
    end

    media = @ele.upload
    @m_array = []
    media.each do |m|
      @m_array.push(m.id)
    end
  end    
  
    
  def updateele
    @mod = Mod.find(params[:id])

    gen = (true && params[:mods]) || {}
    gen['f_del'] = 0

    if @mod.update_attributes(gen)
      @lingue.each do |lang|
        lingua = params[lang.cod]
        lingua['fklang'] = lang.cod
        lingua['fkparent'] = @mod.id
        lingua['url_title'] = sanitize_string(lingua['title'])
        
        sml_mod = @mod.sml.where('fklang=? AND fkparent=?', lang.cod, @mod.id).first
        if !sml_mod.nil?
          if sml_mod.update_attributes(lingua)
            flash[:notice] = 'Elemento aggiornato con successo.'
          else
            error = true
          end
        else
          sml_mod = ModSml.new(lingua)
          if sml_mod.save
            flash[:notice] = 'Elemento aggiornato con successo.'
          else
            error = true
          end
        end

        render 'edit' if error
      end
    end

    redirect_to "/admin/mods/list?idserv=#{@mod.idserv}&idc=#{@mod.fkcat}"
  end


  def destroyele
    mod = Mod.find(params[:id])
    mod.update_attributes({"f_del" => "1"})
    flash[:success] = "Elemento eliminata con successo."
    redirect_to "/admin/mods/list?idserv=#{params[:idserv]}&idc=#{mod.fkcat}"
  end

  def deleteallele
    del_ele = params[:id].split(',')
    del_ele.each { |ele| Mod.find(ele).update_attributes({"f_del" => "1"}) }

    render :nothing => true
  end


  def associafile
    ele = Mod.find(params[:ide])
    ass_ele = params[:id].split(',')
    ass_ele.each do |media|
      Media.delete(Media.where("fkfile=? AND fkmod=?", media, ele.id))

      Media.create!({:fkfile => media, :fkmod => ele.id})
    end
    str = ""

    ele.upload.each do |up|
      str += "
              <li class='span3'>
                <a rel='popover' href='#' id='image-#{up.id}' data-content='<img src=\"#{up.filename_url(:macro)}\"'>
                  <div class='thumbnail'>
                    <img src='#{up.filename_url(:micro)}' />
                    <br>
                    <input type='checkbox' name='rimuovi' id='remove-#{up.id}' value='#{up.id}' />
                  </div>
                </a>
              </li>
            "
    end

    render :json => {"txt" => str}
  end

  def destroyimages
    del_ele = params[:id].split(',')
    del_ele.each do |ele| 
      Media.where("fkfile=? AND fkmod=?", ele, params[:ide]).each { |media| media.destroy }
    end

    render :nothing => true
  end

  def destroyallimages
    Media.where("fkmod=?", params[:id]).each { |ele| ele.destroy }

    redirect_to "/admin/mods/editele?idserv=#{params[:idserv]}&idc=#{params[:idc]}&id=#{params[:id]}"
  end

  def publishedele
    mod = Mod.find(params[:id])

    if mod.published == 1
      mo.update_attributes({"published" => 0})
    else
      mod.update_attributes({"published" => 1})
    end

    redirect_to "/admin/mods/list?idserv=#{mod.idserv}&idc=#{mod.fkcat}"
  end

  def updateorderele
    x = 1
    order_arr = params[:id].split(',')

    order_arr.each_with_index do |id, index|
      #logger.info "#{id} --> #{index}"
      order = {"ordine" => index + 1}

      mod = Mod.find(id.to_i)
      mod.update_attributes(order)
    end

    render :nothing => true
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(admin_root_path) unless current_user?(@user)
    end


end
