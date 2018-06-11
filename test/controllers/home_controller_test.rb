require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "private method request ticket should return JSON tickets" do
  	@controller = HomeController.new
    # private method request_tickets should return a not-nil JSON element 'tickets'
    assert_not_nil @controller.send(:request_tickets, ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_USERNAME'], ENV['ZENDESK_PASSWORD'])['tickets']
  end

  test "if request tickets with wrong username, should raise error" do
    @controller = HomeController.new
    # assert return exception message with wrong username
    exception_message = @controller.send(:request_tickets, ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_NONE_EXIST_USERNAME'], ENV['ZENDESK_PASSWORD'])
    # exception = assert_raise(Faraday::Error::ClientError) {
    #   @controller.send(:request_tickets, ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_NONE_EXIST_USERNAME'], ENV['ZENDESK_PASSWORD'])
    # }
    # exception message should match
    assert_equal("the server responded with status 401", exception_message) 
  end

  test "home page should display error message if there's error" do
    # call request ticket method with wrong username
    @controller = HomeController.new
    @controller.send(:request_tickets, ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_NONE_EXIST_USERNAME'], ENV['ZENDESK_PASSWORD'])
    # go to home page, should display error message
    @controller.index
    assert_select "#subjectPanel" do
      assert_select ".error-msg" do
        assert_select "h4", "Oops we currently run into some problems:"
        assert_select "p"
      end
    end
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

 #  test "page should switch if click page buttons" do
	# end

	
end

