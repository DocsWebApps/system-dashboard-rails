var HomePage={
  init: function() {
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

var SystemIncidents={
  init: function() {
    $('body').css('overflow','hidden');
    $('#details-modal').on('click','.modal-close-btn, .modal-X-btn', function() {
      $('#details-modal').html('');
      $('#details-modal').hide();
      $('body').css('overflow','visible');
    });

    $('#details-modal').on('mouseenter','.modal-close-btn',function() {
      $(this).addClass('inv-btn');
    });
    $('#details-modal').on('mouseleave','.modal-close-btn',function() {
      $(this).removeClass('inv-btn');
    });

    $('#details-modal').on('mouseenter','.modal-X-btn',function() {
      $(this).addClass('inv-X-btn');
    });
    $('#details-modal').on('mouseleave','.modal-X-btn',function() {
      $(this).removeClass('inv-X-btn');
    });
  }
};

var LoginForm={
  init: function() {
    $('#login-modal').on('click', '#cancel-btn', function() {
      $('#login-modal').html('');
      $('#login-modal').hide();
    });
  }
};

$(document).ready(function() {
  HomePage.init();
  SystemIncidents.init();
  LoginForm.init();
});