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

    fill_in "Title", with: @book.title
    click_on "Create Book"

    assert_text "Book was successfully created"
    click_on "Book List"
  end

  test "updating a Book" do
    visit book_url(@book)
    click_on "Edit Book Title"

    fill_in "Title", with: "New Title"
    click_on "Update Book"

    assert_text "Book was successfully updated"
    assert_text "New Title"
    click_on "Book List"
  end

  test "destroying a Book" do
    visit book_url(@book)
    page.accept_confirm do
      click_on "Delete Book", match: :first
    end

    assert_text "Book was successfully destroyed"
  end
end
