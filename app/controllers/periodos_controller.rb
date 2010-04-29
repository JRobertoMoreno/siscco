class PeriodosController < ApplicationController
   before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
#    @periodo_pages, @periodos = paginate :periodos, :per_page => 10
     @periodos = Periodo.find(:all, :order => 'nombre')
  end

  def show
    @periodo = Periodo.find(params[:id])
  end

  def new
    @periodo = Periodo.new
  end

  def create
    @periodo = Periodo.new(params[:periodo])
    if @periodo.save
      flash[:notice] = 'Registro creado satisfactoriamente.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @periodo = Periodo.find(params[:id])
  end

  def update
    @periodo = Periodo.find(params[:id])
    if @periodo.update_attributes(params[:periodo])
      flash[:notice] = 'Registro actualizado.'
      redirect_to :action => 'show', :id => @periodo
    else
      render :action => 'edit'
    end
  end

  def destroy
    Periodo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
                 #-- Ajax --
  def live_search
      @periodos = Periodo.find(:all, :conditions => ["nombre like ?", "%#{params[:searchtext]}%"])
      return render(:partial => 'filtroperiodo', :layout => false) if request.xhr?
  end
      #--- Funciones ajax para filtrado --
end