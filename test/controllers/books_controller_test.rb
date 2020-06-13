require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @book = books(:one)
    @user = users(:user)
    @admin = users(:admin)
  end

  test "if a regular user is signed in, index loads" do
    sign_in @user
    get books_url
    assert_response :success
  end

  test "if no user is signed in, index redirects to sign in" do
    get books_url
    assert_redirected_to new_user_session_path
  end

  test "if regular user is signed in, new redirects to index" do
    sign_in @user
    get new_book_url
    assert_redirected_to books_path
  end

  test "if admin is signed in, new loads" do
    sign_in @admin
    get new_book_url
    assert_response :success
  end

  test "if regular user is signed in, create fails, redirects to index" do
    sign_in @user
    assert_no_difference('Book.count') do
      post books_url, params: { book: { title: @book.title } }
    end
    assert_redirected_to books_path
  end

  test "if admin is signed in, create succeeds" do
    sign_in @admin
    assert_difference('Book.count') do
      post books_url, params: { book: { title: @book.title } }
    end

    assert_redirected_to books_url
  end

  test "if regular user is signed in, edit redirects to index" do
    sign_in @user
    get edit_book_url(@book)
    assert_redirected_to books_path
  end

  test "if admin is signed in, edit succeeds" do
    sign_in @admin
    get edit_book_url(@book)
    assert_response :success
  end

  test "if regular user is signed in, update fails and redirects to index" do
    sign_in @user

    assert_no_changes('@book.updated_at') do
      patch book_url(@book), params: { book: { title: "test" } }
      @book.reload
    end
  end

  test "if admin is signed in, update succeeds" do
    sign_in @admin

    assert_changes('@book.updated_at') do
      patch book_url(@book), params: { book: { title: "test" } }
      @book.reload
    end
  end

  test "if regular user is signed in, destroy fails" do
    sign_in @user
    
    assert_no_difference('Book.count') do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  test "if admin is signed in, destroy succeeds" do
    sign_in @admin

    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
