class ChaptersController < ApplicationController
  def new
    book = Book.find(params[:book])
    next_chapter_number = book.chapters.count + 1
    Chapter.create(book: book, number: next_chapter_number)
    redirect_to book, notice: 'Chapter added successfully'
  end

  def edit
    @chapter = Chapter.find(params[:id])
  end

  def show
    @chapter = Chapter.find(params[:id])
  end

  def update
    chapter = Chapter.find(params[:id])
    if chapter.update(chapter_params)
      redirect_to chapter.book, notice: 'Chapter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    chapter = Chapter.find(params[:id])
    chapter.destroy
    redirect_to chapter.book, notice: 'Chapter was successfully destroyed.'
  end

  private
  def chapter_params
    params.require(:chapter).permit(:title)
  end
end
