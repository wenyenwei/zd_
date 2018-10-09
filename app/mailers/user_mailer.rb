class UserMailer < ApplicationMailer
	def notify_email(user, bookings)
	    @user = user
	    @bookings = bookings

	    mail(to: @user.email, cc: 'susantocompany@gmail.com', subject: 'Updates has been made to your bookings with Susanto')
	end
end
