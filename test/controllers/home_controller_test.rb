require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "request ticket method should return JSON tickets" do
    @controller = HomeController.new
    # private method request_tickets should return a not-nil JSON element 'tickets'
    assert_not_nil @controller.send(:request_tickets)['tickets']
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

