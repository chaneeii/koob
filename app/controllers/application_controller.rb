class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_paramemter_sanitizer.for(:signup) << :fullname
      devise_paramemter_sanitizer.for(:account_update) << :fullname
    end

end
