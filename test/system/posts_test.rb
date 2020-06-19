require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user)
    @book = books(:three_chapters)
    @chapter = chapters(:chapter_3_of_3)
  end

  test "user can view all posts for a chapter" do
    sign_in @user
    visit chapter_posts_url(@chapter)
    assert_text "#{ @book.title }"
    assert_text "Chapter 3 Discussion"
  end

  test "non-user can't see posts" do
    visit chapter_posts_url(@chapter)
    assert_current_path new_user_session_path
  end

  test "can only edit posts that belong to user" do
    sign_in @user
    visit chapter_posts_url(@chapter)
    assert_selector ".edit-post-link", count: 3
  end

  test "navigating back to the chapters list" do
    sign_in @user
    visit chapter_posts_url(@chapter)
    click_on "Back"
    assert_current_path book_chapters_path(@book)
  end

  test "creating new post" do
    sign_in @user
    visit chapter_posts_url(@chapter)
    fill_in "Title", with: "Title of My Post"
    find(:css, '#post_content').click.set("Hello, world")
    click_on "Create Post"

    assert_text "Post created successfully"
  end

  test "editing a post" do
    sign_in @user
    visit chapter_posts_url(@chapter)
    click_on "Edit", class: "edit-post-link", match: :first
    assert_text "Editing"

    new_title = "Edited Post"

    fill_in "Title", with: new_title
    click_on "Update"

    assert_text "Chapter 3 Discussion"
    assert_text new_title
  end

  test "user can only delete posts that belong to them" do
    sign_in @user
    visit chapter_posts_url(@chapter)
    assert_selector ".delete-post-link", count: 3
  end

  test "deleting a post as a user" do
    sign_in @user
    visit chapter_posts_url(@chapter)
    
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
