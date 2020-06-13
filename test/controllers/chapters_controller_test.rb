require 'test_helper'

class ChaptersControllerTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers

  setup do
    @book = books(:three_chapters)
    @chapter = @book.chapters.first
    @user = users(:user)
    @admin = users(:admin)
  end

  test 'if a regular user is signed in, index loads' do
    sign_in @user
    get book_chapters_url(@book)
    assert_response :success
  end

  test 'if no user is signed in, index redirects to sign in' do
    get book_chapters_url(@book)
    assert_redirected_to new_user_session_path
  end

  test "if regular user, create fails" do
    sign_in @user
    assert_no_difference('Chapter.count') do
      post book_chapters_url(@book), params: { chapter: { book: @book, title: "Chapter 1", number: 1 }}
    end
  end

  test "if admin, create succeeds" do
    sign_in @admin
    assert_difference('Chapter.count') do
      post book_chapters_url(@book), params: { chapter: { book: @book, title: "Chapter 1", number: 1 }}
    end
  end

  test "if regular user, edit fails" do
    sign_in @user
    get edit_chapter_url(@chapter)
    assert_response :redirect
  end

  test "if admin, edit succeeds" do
    sign_in @admin
    get edit_chapter_url(@chapter)
    assert_response :success
  end

  test "if regular user, update fails" do
    sign_in @user
    assert_no_changes '@chapter.updated_at' do
      patch chapter_url(@chapter), params: { chapter: { title: "Updated" }}
      @chapter.reload
    end
  end

  test "if admin, update succeeds" do
    sign_in @admin
    assert_changes '@chapter.updated_at' do
      patch chapter_url(@chapter), params: { chapter: { title: "Updated" }}
      @chapter.reload
    end
  end

  test "if regular user, destroy fails" do
    sign_in @user
    assert_no_difference('Chapter.count') do
      delete chapter_url(@chapter)
    end
  end

  test "if admin, destroy succeeds" do
    sign_in @admin
    assert_difference('Chapter.count', -1) do
      delete chapter_url(@chapter)
    end
  end

end
