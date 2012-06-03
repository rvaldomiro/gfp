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

end