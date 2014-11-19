$(function(){
  $(".bring_form").on("click", function(e){
    e.preventDefault();
    url = $(this).attr('href')
    $.get(url, function(response){
      $('.form_space').html(response)
    })
  })

  $(".form_space").on("submit", "#signup_form", function(e){
    e.preventDefault();
    console.log()
    url = $(this).attr('action')
    data = $(this).serialize();
    $.post(url, data, function(r){
      $.get('/users/login', function(response){
        $('.form_space').html(response);
      });
    })
  })

  $(".edit").on('click', function(e){
    e.preventDefault();
    $(this).data("event-id") // 
    url = $(this).attr('href')
    div_id = url.match(/\d+/)
    $.get(url, function(response){
      $("#" + div_id).html(response)
    })
  })

  // var fooReq = $.get("/foo");
  // var barReq = $.get("/bar");
  // $.when(fooReq, barReq).done(function(){    })

  $(document).on('submit', '#edit_form', function(e){
    e.preventDefault();
    data = $(this).serialize();
    url = $(this).attr('action')
    $.post(url, data, function(response){
      $('.container').html(response)
    })
  })

  $('.container').on('click','.delete', function(e){
    e.preventDefault();
    url = $(this).attr('href')
    $.get(url, function(response){
      $('.container').html(response)
    })
  })
})