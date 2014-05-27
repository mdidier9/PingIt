class UserCategoriesController < ApplicationController
  def update
    p params
    user_cat = UserCategory.find(params[:id])
    user_cat.listening_status = params[:new_listening_status]
    user_cat.save

    render json: {listening: user_cat.listening_status}
  end
end