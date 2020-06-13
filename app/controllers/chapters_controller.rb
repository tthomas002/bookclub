class ChaptersController < ApplicationController
  before_action :admin_authorization, only: [:create, :edit, :update, :destroy]

  def index
    @book = Book.find(params[:book_id])
    @chapter = Chapter.new
  end

  def create
    @book = Book.find(params[:book_id])
    @chapter = Chapter.new(chapter_params)
    @chapter.number = @book.next_chapter_number
    @chapter.book_id = params[:book_id]

    if @chapter.save
      redirect_to book_chapters_path(@chapter.book), notice: "Chapter successfully created"
    else
      flash.now[:notice] = "Chapter creation unsuccessful"
      render :index
    end
  end

  def edit
    @chapter = Chapter.find(params[:id])
  end

  def update
    @chapter = Chapter.find(params[:id])
    if @chapter.update(chapter_params)
      redirect_to book_chapters_path(@chapter.book), notice: 'Chapter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    chapter = Chapter.find(params[:id])
    chapter.destroy
    redirect_to book_chapters_path(chapter.book), notice: 'Chapter was successfully destroyed.'
  end

  private
  def chapter_params
    params.require(:chapter).permit(:title)
  end

  def admin_authorization
    redirect_to root_path unless current_user.admin?
  end
end
