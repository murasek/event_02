class RelationshipsController < ApplicationController
    before_action :authenticate_user!
  respond_to :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    if @user != current_user
    current_user.follow!(@user)
    respond_with @user
  else
  end
  end
def destroy
  @user = Relationship.find(params[:id]).followed
  current_user.unfollow!(@user)
  respond_with @user
end
end
