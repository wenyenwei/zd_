require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "request ticket method should return JSON tickets" do
    @controller = HomeController.new
    # private method request_tickets should return a not-nil JSON element 'tickets'
    assert_not_nil @controller.send(:request_tickets,  ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_USERNAME'], ENV['ZENDESK_PASSWORD'])['tickets']
  end

  test "if request tickets with wrong username, should return error message" do
    @controller = HomeController.new
    # assert return exception message with wrong username
    exception_message = @controller.send(:request_tickets, ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_NONE_EXIST_USERNAME'], ENV['ZENDESK_PASSWORD'])
    assert_equal("the server responded with status 401", exception_message) 
  end

  test "home page should render successfully and show tickets" do
    get root_path
    # get home page response success 
    assert_response :success
    # show header
    assert_select "h1", "Zendesk Intern Challenge"
    # show tickets listing under #subjectPanel
    assert_select "#subjectPanel" do
      assert_select "li.subject_panel"
    end
  end

end

