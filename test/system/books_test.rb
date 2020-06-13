require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "creating a Book" do
    visit books_url
    click_on "New Book"

    fill_in "Title", with: "Test Title"
    click_on "Create Book"

    assert_text "Book was successfully created"
    assert_text "Test Title"
  end

  test "updating a Book" do
    visit books_url
    click_on "Edit", match: :first

    fill_in "Title", with: "New Title"
    click_on "Update Book"

    assert_text "Book was successfully updated"
    assert_text "New Title"
  end

  test "destroying a Book" do
    visit books_url
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Book was successfully destroyed"
  end
end
