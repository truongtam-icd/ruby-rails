class AccountController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    user = User.try_to_login(auth_params[:user], auth_params[:password])
    if user
      jwt = User.token(auth_params[:user], auth_params[:password])
      cookies[:token] = jwt
      redirect_to "/user/1"
    else
      @error = "Wrong user or password"
      render :template => "home/index"
    end
  end

  def logout
    cookies.delete(:token)
    redirect_to "/"
  end

  def user
    token = cookies[:token]
    data = Auth.decode(token)
    if data
      render :template => "account/user"
    else
      cookies.delete(:token)
      redirect_to "/"
    end
  end

  def getToken
    jwt = User.token("admin", "admin")
    render json: {token: jwt}
  end

  private
  def auth_params
    params.permit(:user, :password)
  end
end
