require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  # test "request response status should be 200" do
  # 	assert_equal "200", @response.status
  # end

  test "response body @ticket_info type should be JSON" do
  	get root_path
  	puts 'controller',@controller.inspect

  	assert_equal "application/json", @ticket_info.content_type
  end

  test "should be success loading homepage and show header" do
    get root_path 
    assert_response :success
  end

 #  test "home page should show tickets" do
 #  end

 #  test "page should switch if click page buttons" do
	# end

	
end

