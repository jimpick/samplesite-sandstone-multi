# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include AuthenticatedSystem
  include SandstoneSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'fd97404df2b1494d5f5308f996b20d1f'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  # Multisite support
  # http://railstips.org/2006/11/13/building-a-multi-site-supported-application
  include AccountLocation

  before_filter :find_current_site
  helper_method :current_site
  attr_reader   :current_site
  helper_method :current_subsite
  attr_reader   :current_subsite

  private

    def find_current_site
      @current_site = Site.find_by_subdomain(account_subdomain)
      @current_subsite = @current_site
    end

end
