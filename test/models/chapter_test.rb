require 'test_helper'

class ChapterTest < ActiveSupport::TestCase
  test "number cant be blank" do
    chapter_without_number = Chapter.new(book: books(:one), title: "No Number")
    assert_not chapter_without_number.save
  end

  test "number cant be negative" do
    chapter_with_negative = Chapter.new(book: books(:one), number: -1, title: "Negative Number")
    assert_not chapter_with_negative.save
  end

  test "number cant be zero" do
    chapter_with_zero = Chapter.new(book: books(:one), number: 0, title: "Chapter Zero")
    assert_not chapter_with_zero.save
  end

  test "title cant be blank" do
    chapter_without_title = Chapter.new(book: books(:one), number: 1)
    assert_not chapter_without_title.save
  end
end
