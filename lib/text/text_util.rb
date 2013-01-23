require 'net/https'


class Texter
	ACCOUNT_NUMBER = '7756575726'
	API_KEY = '049d2b1dd2d87936814325c80db9b9ee41363785'
	USER_ID = '2978488'

	def self.send_text(content)
		data = {contacts: [USER_ID], text: content}

		uri = URI.parse("https://api.sendhub.com/v1/messages/?username=#{ACCOUNT_NUMBER}\&api_key=#{API_KEY}")
		req = Net::HTTP::Post.new(uri.request_uri)
		req.add_field("Content-Type","application/json")
		req.body = data.to_json

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		res = http.request(req)

		return res.code == 201
	end

end

