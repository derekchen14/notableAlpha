require 'mail'

# Mail.defaults do
# 	delivery_method
# 	<some code>
# end

class Mailer

	DEFAULT_EMAIL = 'Derek <derek@notable.com>'
	ADMIN_EMAIL = 'admin <admin@notable.com>'

	def self.fancy
		puts "hi i'm fancy"
	end

	def self.send_default_email
		self.send_mail()
	end

	def self.send_admin_email
		self.send_mail(ADMIN_EMAIL)
	end

	private
			def self.send_mail(from_email=DEFAULT_EMAIL)
				mail = Mail.deliver do
					to 'brian@copilotlabs.com'
					from from_email
					subject 'hi subject'
					text_part do
						body 'Hello weold'
					end
				end
			end

end
