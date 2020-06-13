require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "title cant be blank" do
    assert_not Book.new.save
  end

  test "next_chapter_number" do
    book_one = books(:no_chapters)
    book_two = books(:one_chapter)
    book_three = books(:three_chapters)
    assert_equal(1, book_one.next_chapter_number)
    assert_equal(2, book_two.next_chapter_number)
    assert_equal(4, book_three.next_chapter_number)
  end
end
