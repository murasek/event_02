class TicketsController < ApplicationController


before_action :authenticate_user!

def new
   raise ActionController::RoutingError,'ログイン状態でTicketsController#new'
 end

 def create

     ticket = current_user.tickets.build do |t|

       t.event_id = params[:event_id]
       t.comment = params[:ticket][:comment]


 end

if ticket.save
  # binding.pry
flash[:notice]= 'このイベントに参加表明しました'
  head 201

# redirect_to event_tickets_path, notice: "イベントに参加表明しました！"
else
render json:{ messages: ticket.errors.full_messages }, status:422
redirect_to event_path, notice: "すでに参加しています！"
 end
end

def destroy
  ticket = current_user.tickets.find_by!(event_id: params[:event_id])
  ticket.destroy!
  redirect_to event_path(params[:event_id]), notice: 'このイベントの参加をキャンセルしました'
end
end
