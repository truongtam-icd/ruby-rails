class RegisterController < ApplicationController
  def index
    if request.request_method == "POST"
      status = User.insert_user({
        login: params[:user],
        password: params[:password],
        email: params[:email],
        firstname: params[:firstname],
        lastname: params[:lastname]
      })
      if status
        redirect_to "/"
      else
        flash[:error_register] = "User exits"
        redirect_to "/register"
      end
    end
  end
  render :template => "register/index"
end
