class UsuarioSessionsController < ApplicationController


  access_control do
    allow all, :to => [:new, :create]
    allow :admin, :to => [:destroy]
  end

  # GET /usuario_sessions/new
  # GET /usuario_sessions/new.xml
  def new
    @usuario_session = UsuarioSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario_session }
    end
  end

  # POST /usuario_sessions
  # POST /usuario_sessions.xml
  def create
    @usuario_session = UsuarioSession.new(params[:usuario_session])

    respond_to do |format|
      if @usuario_session.save
        format.html { redirect_to(requisicoes_path) }
        format.xml  { render :xml => @usuario_session, :status => :created, :location => @usuario_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usuario_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuario_sessions/1
  # DELETE /usuario_sessions/1.xml
  def destroy
    @usuario_session = UsuarioSession.find(params[:id])
    @usuario_session.destroy

    respond_to do |format|
      format.html { redirect_to(admin_path) }
      format.xml  { head :ok }
    end
  end
end

