//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

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
