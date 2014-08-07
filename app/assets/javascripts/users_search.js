$(function() {

  $('#users_bid_search input').keyup(function(e) {
    var form = $('#users_bid_search')
    // This is the <ul>
    $('#users').load("/bids/new", form.serialize());
  });

  $('#users').on("click", ".select_receiver_link", function(e) {
  		e.preventDefault();
  		value = $(e.target).attr('id');
  		$('#bid_receiver_id').val(value).change();

  });

  $("#bid_receiver_id").change(function(e) {
  	if ($("#bid_receiver_id").val().length){
  		$('#new_bid input.btn.btn-black').attr("disabled", false)
  	}
	else {
  		$('#new_bid input.btn.btn-black').attr("disabled", true)
	}
  });

});