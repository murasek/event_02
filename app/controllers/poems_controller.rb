class PoemsController < ApplicationController
  def index
    @poems = Poem.all
  end
   def show
   @poem = Poem.find(params[:id])
    render json: @poem
   end
end