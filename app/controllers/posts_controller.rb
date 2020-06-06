class PostsController < ApplicationController
  def new
    @chapter = Chapter.find(params[:chapter])
    @post = Post.new(chapter: @chapter)
  end

  def create
    @chapter = Chapter.find(params[:post][:chapter_id])
    @post = Post.new(post_params)

    if @post.save
      redirect_to @chapter, notice: "Post created successfully"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :chapter_id)
  end
end
