class StoriesController < ApplicationController
before_action :authenticate_user!
before_action :find_story, only: [:edit, :update, :destroy]

def index
  @stories = current_user.stories.order(created_at: :desc)
  
end

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

  def edit
    
  end

  def update
    if @story.update(stroy_params)
      redirect_to stories_path, notice: "投稿を更新しました！"
    else
      render :edit
    end
  end

  private
  def find_story
  @story = current_user.stories.find(params[:id])
  end

  def stroy_params
    params.require(:story).permit(:title, :content)   
  end
end
