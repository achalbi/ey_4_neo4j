module SessionsHelper

	def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
    session[:return_to] = root_url
  end

   def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by remember_token: cookies[:remember_token]
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    session.delete(:return_to)
    cookies.delete(:remember_token)
    session[:return_to] = root_url
  end

    def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end 

    def signed_in_user
      unless signed_in?
        store_location
        #redirect_to signin_url, notice: "Please sign in."
        redirect_to root_url, notice: "Please sign in."
      end
    end


  def remote_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '117.192.176.246'
    else
      request.remote_ip
    end
  end


  def facebook
    @graph = Koala::Facebook::API.new(session['fb_access_token'])
  end

  def fb_friends
      @friends = Array.new
    if session["fb_access_token"].present?
      # @profile_image = graph.get_picture("me")
      # @fbprofile = graph.get_object("me")
      @friends = facebook.get_connections("me", "friends")
    end
    @friends
  end

    
end
