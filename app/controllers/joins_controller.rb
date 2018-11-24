class JoinsController < ApplicationController  before_action :authenticate

  # before_action :authenticate
  #
  # def new
  #   raise ActionController::RoutingError, 'ログイン状態で TicketsController#new にアクセス'
  # end
  #
  # def create
  #   join = current_user.joins.build do |t|
  #     t.event_id = params[:event_id]
  #
  #   if join.save
  #     flash[:notice] = 'このイベントに参加表明しました'
  #     head 201
  #   else
  #     render json: { messages: join.errors.full_messages }, status: 422
  #   end
  # end
  #
  # def destroy
  #   join = current_user.joins.find_by!(event_id: params[:event_id])
  #   join.destroy!
  #   redirect_to event_path(params[:event_id]), notice: 'このイベントの参加をキャンセルしました'
  # end
end
