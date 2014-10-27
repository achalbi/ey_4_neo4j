class StaticPagesController < ApplicationController

  def home
  	@user = current_user
  	unless @user.nil?
  		@pictures = @user.pictures.nil? ? []: @user.pictures
  	end
  end

  def help
  end
end
