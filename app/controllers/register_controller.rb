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
        return
      end
      redirect_to "/register/new"
      return
    end
    render :template => "register/index"
  end

  def new
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
        return
      end
    end
    @error = "Wrong user or password"
    render :template => "register/index"
  end
end
