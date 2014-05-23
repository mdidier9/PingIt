class UsersController < ApplicationController
  def update
    puts params[:latitude]
    render :json => "true"
  end
end
