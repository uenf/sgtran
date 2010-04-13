# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  rescue_from Acl9::AccessDenied, :with => :access_denied
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

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

  if RAILS_ENV == "production"
    HoptoadNotifier.configure do |config|
      config.api_key = '03362ff5fe7c6ca1023358717bc1c713'
      config.ignore_only  = []
    end
  end
  



  def local_request?
    false
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_user

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

