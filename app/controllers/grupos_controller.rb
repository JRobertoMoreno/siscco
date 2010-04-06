class GruposController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @grupo_pages, @grupos = paginate :grupos, :per_page => 10
  end

  def show
    @grupo = Grupo.find(params[:id])
  end

  def new
    @grupo = Grupo.new
  end

  def create
    @grupo = Grupo.new(params[:grupo])
    if @grupo.save
      flash[:notice] = 'Grupo was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @grupo = Grupo.find(params[:id])
  end

  def update
    @grupo = Grupo.find(params[:id])
    if @grupo.update_attributes(params[:grupo])
      flash[:notice] = 'Grupo was successfully updated.'
      redirect_to :action => 'show', :id => @grupo
    else
      render :action => 'edit'
    end
  end

  def destroy
    Grupo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
