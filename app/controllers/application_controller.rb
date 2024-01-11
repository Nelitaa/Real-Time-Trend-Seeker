class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= find_or_create_user_by_ip
  end

  private

  def find_or_create_user_by_ip
    user_ip = request.remote_ip
    User.find_or_create_by(ip: user_ip)
  end
end
