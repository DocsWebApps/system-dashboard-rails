$(document).ready(function() {
	var HomePage={
    setup: function() {
			$('#title-btn, .details-btn').mouseenter(function() {
				$(this).addClass('inv-btn');
			});
			$('#title-btn, .details-btn').mouseleave(function() {
				$(this).removeClass('inv-btn');
			});
			$('.navbar-nav').on('click','li',function() {
				$('li').removeClass('active');
				$(this).addClass('active');
			});
			$('.navbar-brand').on('click', function() {
				$('.navbar-nav').find('li').removeClass('active');
			});
    }
  };

  $(HomePage.setup);
});