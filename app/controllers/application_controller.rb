class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user, :configuracoes

  rescue_from Acl9::AccessDenied, :with => :access_denied
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  filter_parameter_logging :password, :password_confirmation

  def configuracoes
    @configuracao ||= Configuracao.all.first
    @configuracao
  end

  def access_denied
    if current_user.nil?
      redirect_to(new_requisicao_path)
    else
      render :template => "erros/acesso_negado", :layout => "erros"
    end
  end

  def render_404
    render :template => "erros/erro_404", :status => "404 Not Found", :layout => "erros"
  end

  def render_optional_error_file(status_code)
    if status_code == :internal_server_error
      render :template => "erros/erro_500.html.erb", :status => "500 Internal Server Error", :layout => "erros"
    end
  end

  def local_request?
    false
  end

  private
  def current_session
    return @current_session if defined?(@current_session)
    @current_session = UsuarioSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_session && current_session.record
  end

  private
  def activate_authlogic
    Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self)
  end
end

