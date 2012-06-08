// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function() {  

  $("#session_remember_me").click(function() {
   	if (!this.checked) {
   		$("#session_password").attr("value", null);
  	}
  });

  window.setTimeout(function() {
    $(".alert-warning").fadeTo(500, 0).slideUp(500, function() {
    	$(this).remove(); 
    });

    $(".alert-error").fadeTo(500, 0).slideUp(500, function() {
    	$(this).remove(); 
    });

    $(".alert-info").fadeTo(500, 0).slideUp(500, function() {
    	$(this).remove(); 
    });

    $(".alert-success").fadeTo(500, 0).slideUp(500, function() {
    	$(this).remove(); 
    });
	}, 5000);

});