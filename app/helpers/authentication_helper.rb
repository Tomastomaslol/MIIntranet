module AuthenticationHelper
  def signed_in?
    !session[:user_id].nil?
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id])
  end
  
  def ensure_signed_in
    unless signed_in?
      session[:redirect_to] = request.url
      redirect_to(signin_path)
    end
  end
  
  def current_user?(user)
     (user == current_user) || (current_user.admin?)
  end
end