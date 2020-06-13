require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase

  setup do
    @test_book = books(:three_chapters)
    visit book_chapters_url(@test_book)
    click_on "third chapter"
  end

  test "viewing all posts for a chapter" do
    assert_text "#{ @test_book.title }"
    assert_text "Chapter 3 Discussion"
  end

  test "navigating back to the chapters list" do
    click_on "Back"
    assert_current_path book_chapters_path(@test_book)
  end

  test "creating new post" do
    fill_in "Title", with: "Title of My Post"
    find(:css, '#post_content').click.set("Hello, world")
    click_on "Create Post"

    assert_text "Post created successfully"
  end

  test "editing a post" do
    click_on "Edit", match: :first
    assert_text "Editing"
    assert_text "This is the content"

    new_title = "Edited Post"

    fill_in "Title", with: new_title
    click_on "Update"

    assert_text "Chapter 3 Discussion"
    assert_text new_title
  end

  test "deleting a post" do

    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
