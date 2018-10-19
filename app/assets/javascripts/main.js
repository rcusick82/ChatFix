$(document).ready(function() {

	// INITIATE THE FOOTER
  siteFooter();
	// COULD BE SIMPLIFIED FOR THIS PEN BUT I WANT TO MAKE IT AS EASY TO PUT INTO YOUR SITE AS POSSIBLE
	$(window).resize(function() {
		siteFooter();
	});

	function siteFooter() {
  var siteContent = $('#site-content');
  var siteContentHeight = siteContent.height();
  var siteContentWidth = siteContent.width();

  var siteFooter = $('#site-footer');
  var siteFooterHeight = siteFooter.height();
  var siteFooterWidth = siteFooter.width();

  console.log('Content Height = ' + siteContentHeight + 'px');
  console.log('Content Width = ' + siteContentWidth + 'px');
  console.log('Footer Height = ' + siteFooterHeight + 'px');
  console.log('Footer Width = ' + siteFooterWidth + 'px');

  siteContent.css({
			"margin-bottom" : siteFooterHeight + 50
		});
	};
});


var $headline = $('.headline')
var $inner = $('.inner')
var $nav = $('nav')
var navHeight = 75
  ;

$(window).scroll(function() {
  var scrollTop = $(this).scrollTop(),
    headlineHeight = $headline.outerHeight() - navHeight,
    navOffset = $nav.offset().top;

  $headline.css({
    'opacity': (1 - scrollTop / headlineHeight)
  });
  $inner.children().css({
    'transform': 'translateY(' + scrollTop * 0.4 + 'px)'
  });
  if (navOffset > headlineHeight) {
    $nav.addClass('scrolled');
  } else {
    $nav.removeClass('scrolled');
  }
});
