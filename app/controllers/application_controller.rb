class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_cookie
  
  private
  
  def set_cookie
    unless cookies[:crunchhunch]
      cookies[:crunchhunch] = ActiveSupport::SecureRandom.base64.gsub("/","_").gsub(/=+$/,"")
    end
  end
end
