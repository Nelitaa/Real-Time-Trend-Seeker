class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= find_or_create_user_by_ip
  end

  private

  def find_or_create_user_by_ip
    user_ip = request.remote_ip
    Rails.cache.fetch("user_#{user_ip}", expires_in: 1.day) do
      User.find_or_create_by(ip: user_ip)
    end
  end
end
