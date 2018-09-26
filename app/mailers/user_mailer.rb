class UserMailer < ApplicationMailer
	def notify_email(user, bookings)
	    @user = user
	    @bookings = bookings

	    mail(to: @user.email, cc: 'wenyen.wei@student.unimelb.edu.au', subject: 'Updates has been made to your bookings with Susanto')
	end
end
