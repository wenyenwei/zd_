'require home_controller'

RSpec.describe HomeController, "#response" do
	context "connection response success" do
		it "shows if connection is successful" do
			home_controller = HomeController.new
			home_controller.request_tickets
			expect(home_controller.response.status).to eq 200
		end
	end
end