class TweetsController < ApplicationController
 before_action :set_tweet, only: [:edit, :update, :destroy]
  
  def index
    @tweets = Tweet.all
  end

  def new
    if params[:back]
      @tweet = Tweet.new(tweets_params)
    else
      @tweet = Tweet.new
    end
  end

 def create
    @tweet = Tweet.new(tweets_params)
    if @tweet.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to tweets_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
 end

  def edit
    
  end
    
  def update
   
    if @tweet.update(tweets_params)
    redirect_to tweets_path
    else
     render 'edit' 
    end
  end
  
  def destroy
    
    @tweet.destroy
    redirect_to tweets_path, notice: "ブログを削除しました！"
  end
  
  def confirm
   @tweet = Tweet.new(tweets_params)
    render :new if @tweet.invalid?
  end
  
  
  
   private
    def tweets_params
      params.require(:tweet).permit(:title, :content)
    end
    def set_blog
      @tweet = Tweet.find(params[:id])
    end
end 
    
