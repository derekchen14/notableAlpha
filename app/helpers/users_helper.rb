module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end

  def display_number(phone_number)
  	if (phone_number.nil? || phone_number.length == 0)
  	  return "N/A"
  	end
  	n = "(" + phone_number[0,3].to_s + ")"
  	n += phone_number[3,3].to_s + "-" + phone_number[6,4].to_s
  	return n
  end

end