module ApplicationHelper

	#Page Title Helper
	def title 
		baseTitle = "Ruby on Rails Tutorial Sample App"

		#if @title variable for page name is nil use baseTitle only
		if @title.nil?
			baseTitle
		else #use base title plus modifier
			"#{baseTitle} | #{@title}"

		end
	end

	#Logo Link Helper
	def logo
		logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
	end
end
