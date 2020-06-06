require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase

  setup do
    @test_book = books(:one)
    visit book_url(@test_book)
    click_on "Chapter 1"
  end

  test "viewing all posts for a chapter" do
    assert_text "#{ @test_book.title }"
    assert_text "Chapter 1 Discussion"
  end

  test "adding new post" do
    click_on "New Post"
    find(:css, '#post_content').click.set("Hello, world")
    click_on "Create Post"

    assert_text "Discussion"
  end
end
