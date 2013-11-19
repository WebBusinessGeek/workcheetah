$(document).ready(function(){  
  
  var s = skrollr.init({
    smoothscrolling: true,
    forceHeight: false
  });

  skrollr.menu.init(s, {
    animate: true,
    easing: 'sqrt',
    duration: function(currentTop, targetTop) {
      return 600;
    },
  });

  // var images = ['http://placehold.it/100/113300','http://placehold.it/100/44FFFF','http://placehold.it/100/3000FF', 'http://placehold.it/100/FF00FF','http://placehold.it/100/FFFFFF','http://placehold.it/100/000000','http://placehold.it/100/4400FF','http://placehold.it/100/4444FF','http://placehold.it/100/4433FF'];
  // $('#myCarousel').carousel({interval:4000}); 
  // $(".item.active div.images").append('<img src="' + images[0] + '" class="img-responsive" style="float:left;">');
  // setTimeout(function(){
  //   $(".item.active div.images").append('<img src="' + images[1] + '" class="img-responsive" style="float:left;">');
  // },1000);
  // setTimeout(function(){
  //   $(".item.active div.images").append('<img src="' + images[2] + '" class="img-responsive" style="float:left;">');
  // },2000);

  // $('#myCarousel').on('slide.bs.carousel', function () {  
  //   $(".item.active div.images").html('');
  // }); 
  
  // $('#myCarousel').on('slid.bs.carousel', function () {
  //   var index=$(this).find('.active').index();
  //   $(".item.active div.images").append('<img src="' + images[((index*3))] + '" class="img-responsive" style="float:left;">');
  //   setTimeout(function(){
  //     $(".item.active div.images").append('<img src="' + images[((index*3)+1)] + '" class="img-responsive" style="float:left;">');
  //   },1000);
  //   setTimeout(function(){
  //     $(".item.active div.images").append('<img src="' + images[((index*3)+2)] + '" class="img-responsive" style="float:left;">');
  //   },2000);
  // });

  // $('.carousel .item').each(function(){
  //   var next = $(this).next();
  //   if (!next.length) {
  //     next = $(this).siblings(':first');
  //   }
  //   next.find('.item-content:first-child').clone().appendTo($(this));
  // });

  // var $root = $('body');
  // $('.sectionnext').addEvent('click', function() {
  //   var now = window.location.hash;
  //   var next = parseInt(now.charAt(now.length-1))+1;
  //   var nextlink = "section-" + next.toString();
  //   var offset = s.relativeToAbsolute(document.getElementById(nextlink), 'top', 'bottom');
  //   $root.animate({
  //       scrollTop: $(nextlink).offset.top
  //   }, 600, function (e) {
  //       e.preventDefault();
  //       e.stopPropagation();
  //       window.location.hash = "#"+nextlink;
  //   });
  //   return false;
  // });


});