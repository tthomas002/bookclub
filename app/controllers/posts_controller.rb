class PostsController < ApplicationController
  def index
    @chapter = Chapter.find(params[:chapter_id])
    @post = Post.new
  end

  def create
    @chapter = Chapter.find(params[:chapter_id])
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.chapter_id = @chapter.id

    if @post.save
      redirect_to chapter_posts_path(@chapter), notice: "Post created successfully"
    else
      flash.now[:notice] = "Post creation unsuccessful"
      render :index
    end
  end

  def edit
    @chapter = Chapter.find(params[:chapter_id])
    @post = Post.find(params[:id])

    if @post.user != current_user
      redirect_to chapter_posts_path(@chapter), notice: "You cannot edit that post"
    end
  end

  def update
    @chapter = Chapter.find(params[:chapter_id])
    @post = Post.find(params[:id])

    if @post.user != current_user
      redirect_to chapter_posts_path(@chapter), notice: "You cannot update that post"
    elsif @post.update(post_params)
      redirect_to chapter_posts_path(@chapter), notice: 'Post was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to chapter_posts_path(@post.chapter), notice: "You cannot delete that post"
    else
      @post.destroy
      redirect_to chapter_posts_path(@post.chapter), notice: "Post was successfully destroyed"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
