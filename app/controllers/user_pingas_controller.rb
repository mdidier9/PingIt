class UserPingasController < ApplicationController
  def update
    user_pinga = UserPinga.find(params[:id])
    if params[:rsvp_status] == "attending"
      user_pinga.rsvp_status = params[:rsvp_status]
    else
      user_pinga.rsvp_status = nil
    end
    user_pinga.save

    if user_pinga.rsvp_status == "attending"
      render json: {attending: true}
    else
      render json: {attending: false}
    end
  end
end