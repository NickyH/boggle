class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  private
  def authenticate
    @auth = (session[:user_id].present?) ? User.find(session[:user_id]) : nil
  end

  def check_if_logged_in
    if @auth.nil?
      redirect_to(root_path)
    end
  end
end
