class StoriesController < ApplicationController
before_action :authenticate_user!

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(stroy_params)

    if @story.save
      redirect_to stories_path, notice: "保存されました！"

    else
      render :new
    end
    
  end



  private
  def stroy_params
    params.require(:story).permit(:title, :content)   
  end
end
