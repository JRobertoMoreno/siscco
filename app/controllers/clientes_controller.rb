class ClientesController < ApplicationController
  before_filter :login_required
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
#     @clientes = Cliente.find(:all, :select => "id, paterno, materno, nombre, curp, identificador",
#                              :order => 'paterno, materno, nombre')
     @clientes = Cliente.find_by_sql("select id, paterno, materno, nombre, curp, identificador from clientes LIMIT 0")
     
  end

  def show
    @cliente = Cliente.find(params[:id])
    @negocio = Negocio.find(:first, :conditions => ["cliente_id = ?", params[:id]])
    @civiles = Civil.find(:all)
    @escolaridades = Escolaridad.find(:all)
    @viviendas = Vivienda.find(:all)
    @nacionalidades = Nacionalidad.find(:all, :order => "pais_gent")
  end

  def new
    @cliente = Cliente.new
    @negocio = Negocio.new
    $localidades = Localidad.find_by_sql("select * from localidads LIMIT 0")
    @grupo = Grupo.new
    @roles = RolHogar.find(:all)
    a=0
  end

  def create
    inserta_cliente(Cliente.new(params[:cliente]), Negocio.new(params[:negocio]),  "Registro creado satisfactoriamente ")
  end

  def edit
    @cliente = Cliente.find(params[:id])
    @negocio = Negocio.find(:first, :conditions => ["cliente_id = ?", params[:id]])
    @civiles = Civil.find(:all)
    @escolaridades = Escolaridad.find(:all)
    @viviendas = Vivienda.find(:all)
    $localidades = Localidad.find_by_sql("select * from localidads")
    @roles = RolHogar.find(:all)
  end

  def editc
    @cliente = Cliente.find(params[:id])
    @civiles = Civil.find(:all)
    @escolaridades = Escolaridad.find(:all)
    @viviendas = Vivienda.find(:all)
  end

  def update
    actualiza_cliente(Cliente.find(params[:id]), params[:cliente], Negocio.find(params[:id_negocio]), params[:negocio])
  end

  def updatec
    @cliente = Cliente.find(params[:id])
    if @cliente.update_attributes(params[:cliente])
      flash[:notice] = 'Registro actualizado.'
      redirect_to :action => 'show', :id => @cliente
    else
      render :action => 'edit'
    end
  end

  def destroy
#    Cliente.find(params[:id]).destroy
#    redirect_to :action => 'list'

    begin
      registro = Cliente.find(:first, :conditions => ["id = ?", params[:id]])
      registro.destroy
    rescue ActiveRecord::StatementInvalid => error
        flash[:notice] = "No se puede eliminar el registro #{registro.nombre}, existen relaciones con otras tablas"
    end
    redirect_to :action => "list"

  end
  
  #--------------- Filtrado Ajax -----------------

  def live_search
    if params[:searchtext].size >= 4
          @clientes = Cliente.find(:all, :select=> "id, paterno, materno, nombre, curp, identificador",
                               :conditions => "(nombre like '%#{params[:searchtext]}%' or paterno like '#{params[:searchtext]}%' or
                                               materno like '#{params[:searchtext]}%')", :order => "paterno, materno, nombre")
          return render(:partial => 'filtrocliente', :layout => false) if request.xhr?
    else
          return render(:partial => 'warning', :layout => false) if request.xhr?
    end
  end

    def live_search_curp
        if params[:curp].size >= 4
           @clientes = Cliente.find(:all, :select=> "id, paterno, materno, nombre, curp, identificador",
                               :conditions => "(curp like '#{params[:curp]}%')", :order => "paterno, materno, nombre")
            return render(:partial => 'filtrocliente', :layout => false) if request.xhr?
        else
            return render(:partial => 'warning', :layout => false) if request.xhr?
        end
    end


  


  def estado_cuenta
    
  end

  def historial_grupos
    @cliente = Cliente.find(params[:id])
    @grupos = Clientegrupo.find(:all, :conditions =>["cliente_id = ? ", @cliente.id], :order => "fecha_inicio, fecha_fin")
    render :layout=>"historico"
  end


  def estado_cuenta_individual
    
  end

  def consultar
    if Cliente.find_by_rfc(params[:cliente][:rfc]) && params[:cliente][:rfc]
      @cliente= Cliente.find_by_rfc(params[:cliente][:rfc])
    else
      flash[:notice]="No existe ese RFC"
      redirect_to :action => "estado_cuenta"
    end
  end

  def consultar_individual
    if Cliente.find_by_rfc(params[:cliente][:rfc]) && params[:cliente][:rfc]
      @cliente= Cliente.find_by_rfc(params[:cliente][:rfc])
    else
      flash[:notice]="No existe ese RFC"
      redirect_to :action => "estado_cuenta"
    end
  end

  def xml
      render :xml => Cliente.find(:all).to_xml
  end

#  def verify_curp
#    @cliente = Cliente.find_by_curp(params[:value].strip)
#    @curp_correcta = false
#    if @cliente
#      @mensaje = "El CURP Ya existe"
#    else
#      if params[:value].strip =~/^[A-Z]{4}\d{6}[A-Z]{6}[A-Z|\d]{2}$/
#         @mensaje = "Curp Correcto"
#         @curp_correcta = true
#      else
#         @mensaje = "El formato de la Curp es incorrecto"
#      end
#    end
#      render :layout => false
#  end
#
  def verify_curp
    @lista_negra = ListaNegra.find_by_curp(params[:value].strip)
    @cliente_existente =  Cliente.find_by_curp(params[:value].strip)
    @mensaje = (@lista_negra) ? "Cliente se encuentra en lista negra" : nil
    @mensaje ||= (@cliente_existente) ? "Cliente ya existe" : nil
    @mensaje ||= (!@mensaje && params[:value].strip =~/^[A-Z]{4}\d{6}[A-Z]{6}[A-Z|\d]{2}$/ ) ? "CURP correcta" : nil
    (@mensaje) ? (@curp_correcta = true) : (@curp_correcta = false)
    (!@mensaje) ? (@mensaje = "formato incorrecto") : nil
    render :layout => false
  end

  def verify_nombre
    @paterno, @materno, @nombre = params[:cliente][:paterno], params[:cliente][:materno], params[:cliente][:nombre]
    @lista_negra = ListaNegra.find(:all, :conditions => ["paterno = ? AND materno= ? AND nombre = ?", @paterno, @materno, @nombre])
    @mensajenombre = (!@lista_negra.empty?) ? "Cliente podría estar en lista negra" : nil
    (!@mensajenombre) ? (@mensajenombre = "cliente validado correctamente") : nil
    render :layout => false
  end
end
