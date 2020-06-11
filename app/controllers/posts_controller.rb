class PostsController < ApplicationController
  def new
    @chapter = Chapter.find(params[:chapter_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @chapter = @post.chapter

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
