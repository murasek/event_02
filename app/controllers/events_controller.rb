class EventsController < ApplicationController
  before_action :authenticate_user!
 before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index

    @events = Event.all
   respond_to do |format|
    format.html
    format.js
   end
  end

  # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
  def show
    @comment = @event.comments.build
    @comments = @event.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end


  def new
    if params[:back]
      @event = Event.new(events_params)
    else
      @event = Event.new
    end
  end

 def create
    @event = Event.new(events_params)
    @event.user_id = current_user.id
    if @event.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to events_path, notice: "トピックを作成しました！"
      NoticeMailer.sendmail_event(@event).deliver
    else
      # 入力フォームを再描画します。
      render 'new'
    end
 end


     def edit

      if @event.user_id != current_user.id
      redirect_to events_path, notice: "権限がないため編集できません"
     else

     end
     end



  def update

    if @event.update(events_params)
    redirect_to events_path
    else
     render 'edit'
    end
  end

  def destroy
    if @event.user_id == current_user.id
     @event.destroy
     redirect_to events_path, notice: "トピックを削除しました！"
    else redirect_to events_path, notice: "権限がないため編集できません"
    end

  end

  def confirm
   @event = Event.new(events_params)
    render :new if @event.invalid?
  end



   private
    def events_params
      params.require(:event).permit(:title, :content,:image,:image_cache)
    end
    def set_event
      @event = Event.find(params[:id])
    end
end
