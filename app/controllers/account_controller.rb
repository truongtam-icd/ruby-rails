class AccountController < ApplicationController
  protect_from_forgery with: :null_session

  def login
    logger.info("Login")
    redirect_to "/user/1"
  end

  def logout
    logger.info("Logout")
  end

  def user
    logger.info("User")
  end
end
