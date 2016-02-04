//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).on('ready page:load', function() {

  signUp('#signup-button','users/new','GET');

  $('#toggle').click(function() {
     $(this).toggleClass('active');
     $('#overlay').toggleClass('open');
    });

})

var signUp = function(selector, url, method) {
  $(selector).on('click', function(event){
    event.preventDefault();
    $.ajax({
      method: method,
      url: url,
    })
    .done(function ( response ) {
      $("#signin-form").fadeOut(function(){
        $("#signin-form").html(response).hide();
      });
      $("#signin-form").fadeIn( "slow" );
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

