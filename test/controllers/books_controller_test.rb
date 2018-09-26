require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { book: { arrival_date: @book.arrival_date, departure_date: @book.departure_date, destination_address: @book.destination_address, message: @book.message, num_of_boxes: @book.num_of_boxes, pickup_address: @book.pickup_address, user_email: @book.user_email } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { arrival_date: @book.arrival_date, departure_date: @book.departure_date, destination_address: @book.destination_address, message: @book.message, num_of_boxes: @book.num_of_boxes, pickup_address: @book.pickup_address, user_email: @book.user_email } }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
