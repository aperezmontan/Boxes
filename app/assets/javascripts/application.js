// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// window.signature =
//   initialize: ->
//     $('.signature svg').each ->
//       paths = $('path, circle, rect', this)
//       delay = 0
//       for path in paths
//         length = path.getTotalLength()
//         previousStrokeLength = speed || 0
//         speed = if length < 100 then 20 else Math.floor(length)
//         delay += previousStrokeLength + 100
//         $(path).css('transition', 'none')
//                .attr('data-length', length)
//                .attr('data-speed', speed)
//                .attr('data-delay', delay)
//                .attr('stroke-dashoffset', length)
//                .attr('stroke-dasharray', length + ',' + length)

//   animate: ->
//     $('.signature svg').each ->
//       paths = $('path, circle, rect', this)
//       for path in paths
//         length = $(path).attr('data-length')
//         speed = $(path).attr('data-speed')
//         delay = $(path).attr('data-delay')
//         $(path).css('transition', 'stroke-dashoffset ' + speed + 'ms ' + delay + 'ms linear')
//                .attr('stroke-dashoffset', '0')

// $(document).ready ->
//   window.signature.initialize()

//   $('button').on 'click', ->
//     window.signature.initialize()
//     setTimeout( ->
//       window.signature.animate()
//     , 500)

// $(window).load ->
//   window.signature.animate()




var signUp = function(selector, url, method) {
  $(selector).on('click', function(event){
    event.preventDefault();
    $.ajax({
      method: method,
      url: url,
    })
    .done(function ( response ) {
      console.log(response);
      $("#login-form-container").fadeOut(function(){
        $("#login-form-container").html(response).hide();
      });
      $("#login-form-container").fadeIn( "slow" );
      });
  })
}

var nav = function(selector, url, method) {
  $(selector).on('click', function(event){
    event.preventDefault();
    $.ajax({
      method: method,
      url: url,
    })
    .done(function ( response ) {
      $( "li" ).removeClass( "active" );
      if (url == '/pools/show'){
        $('#pools').addClass("active");
      }
      $(selector).parent("li").addClass("active");
      $(".page-content").slideToggle( "slow", function(){
        $(".page-content").html(response).hide();
      });
      $(".page-content").slideToggle( "slow" );
      });
  })
}
