class AccountController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    if request.request_method == "POST"
      user = User.try_to_login(auth_params[:user], auth_params[:password])
      if user
        jwt = User.token(auth_params[:user], auth_params[:password])
        cookies[:token] = jwt
        redirect_to "/user/" + user.id.to_s
      else
        flash[:error_login] = "Wrong user or password"
        redirect_to "/"
      end
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
      if request.request_method == "POST"
        user_id = params[:id].to_i
        status = User.update_user(user_id, {
          firstname: params[:firstname],
          lastname: params[:lastname]
        })
        if status
          redirect_to "/user/" + user_id.to_s
          return
        else
          redirect_to "/"
          return
        end
      end

      user_id = data[0]["user"]
      if (params[:id].to_s != user_id.to_s)
        cookies.delete(:token)
        redirect_to "/"
        return
      end
      @user = User.info_user(user_id)
      render :template => "account/user"
    else
      cookies.delete(:token)
      redirect_to "/"
    end
  end

  def getToken
    jwt = User.token(auth_params[:user], auth_params[:password])
    render json: {token: jwt}
  end

  private
  def auth_params
    params.permit(:user, :password)
  end
end
