# -*- encoding : utf-8 -*-
module ApplicationHelper

	def flash_type(type)
		result = "fade in alert alert-"

	  case type
	    when :alert
	      result + "warning"
	    when :error
	      result + "error"
	    when :notice
	      result + "info"
	    when :success
	      result + "success"
	    else
	      type.to_s
	  end
	end

	def link_to_delete(title, action, hint, message, sub=nil)
		message = "#{message}<p><small><i>#{sub}</i></small>" if sub 
		link_to " #{title}", action, rel: "popover", title: "#{title}", "data-content" => "#{hint}", class: "icon-trash", confirm: "#{message}"		
	end

end