# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  rescue_from 'Acl9::AccessDenied', :with => :access_denied

  def access_denied
    if current_user.nil?
      redirect_to(new_requisicao_path)
    else
      redirect_to(requisicoes_path)
    end
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

