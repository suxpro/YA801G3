/**
 * 
 */

$(document).ready(
		function() {
			
// 廣告輪播	
			$('#dashboard').hover(function() {
				$(this).stop().animate({
					left : '0',
					backgroundColor : 'rgb(255,255,255)'
				}, 500, 'easeInSine');// end animate
			}, function() {
				$(this).stop().animate({
					left : '-72px',
					backgroundColor : 'rgb(110,138,195)'
				}, 1500, 'easeOutBounce');// end animate
			});// end hover

			// Events that reset and restart the timer animation when the slides
			// change
			$("#transition-timer-carousel").on(
					"slide.bs.carousel",
					function(event) {
						// The animate class gets removed so that it jumps
						// straight back to 0%
						$(".transition-timer-carousel-progress-bar", this)
								.removeClass("animate").css("width", "0%");
					}).on(
					"slid.bs.carousel",
					function(event) {
						// The slide transition finished, so re-add the animate
						// class so that
						// the timer bar takes time to fill up
						$(".transition-timer-carousel-progress-bar", this)
								.addClass("animate").css("width", "100%");
					});

			// Kick off the initial slide animation when the document is ready
			$(".transition-timer-carousel-progress-bar",
					"#transition-timer-carousel").css("width", "100%");
//back to top
			$(window).scroll(function() {
				if ($(this).scrollTop() > 50) {
					$('#back-to-top').fadeIn();
				} else {
					$('#back-to-top').fadeOut();
				}
			});
			// scroll body to 0px on click
			$('#back-to-top').click(function() {
				$('#back-to-top').tooltip('hide');
				$('body,html').animate({
					scrollTop : 0
				}, 800);
				return false;
			});

			$('#back-to-top').tooltip('show');

//檢視密碼
			$(".reveal").mousedown(function() {
			    $(".pwd").replaceWith($('.pwd').clone().attr('type', 'text'));
			})
			.mouseup(function() {
				$(".pwd").replaceWith($('.pwd').clone().attr('type', 'password'));
			})
			.mouseout(function() {
				$(".pwd").replaceWith($('.pwd').clone().attr('type', 'password'));
			});
			
//Menu
			$('nav, .nav-controller').on('click', function(event) {
			       $('nav').toggleClass('focus');
			   });
			$('nav, .nav-controller').on('mouseover', function(event) {
			       $('nav').addClass('focus');
			   }).on('mouseout', function(event) {
			       $('nav').removeClass('focus');
			   });

			

			
}); // end ready
