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
    @story.status = "published" if params[:publish]

    if @story.save
      if params[:publish]
        redirect_to stories_path, notice: "投稿しました！"
      else
        redirect_to edit_story_path(@story), notice: "下書きが保存されました！"
      end
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @story.update(stroy_params)
      case 
      when params[:publish]
        @story.publish!
        redirect_to stories_path, notice: "ストーリーを投稿しました！"
      when params[:unpublish]
        @story.unpublish!
        redirect_to stories_path, notice: "投稿を取り消しました！"
      else
        redirect_to edit_story_path(@story), notice: "ストーリーを保存しました！"
      end
    else
      render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_path, notice: "投稿を削除しました！"
    
  end

  private
  def find_story
  @story = current_user.stories.friendly.find(params[:id])
  end

  def stroy_params
    params.require(:story).permit(:title, :content)   
  end
end
