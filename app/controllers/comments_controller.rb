class CommentsController < ApplicationController
def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    @notification = @comment.notifications.build(user_id: @topic.user.id )
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました' }
        format.js { render :index }
        unless @comment.topic.user_id == current_user.id
          Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
          })
        end
        Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.topic.user.id, read: false).count
        })
      else
        format.html { render :new }
      end
end

def edit
 @comment = Comment.find(params[:id])
end

def update
  @comment = Comment.find(params[:id])
  if @comment.update(comment_params)
  redirect_to topic_path(@comment.topic), notice:"コメントを編集しました！"
    else
      render 'edit' if @comment.invalid?
    end
  end
end

def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
end

  private
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
  end
