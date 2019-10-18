$(function() {
  $('#new_room_message').on('ajax:success', function(a,b,c ) {
    $(this).find('input[type="text"]').val('');
    $(this).find('input').removeClass('is-invalid');
    $('.chat .chat-empty').fadeOut();
  });

  $('#new_room_message').on('ajax:error', function(a,b,c ) {
    $(this).find('input').addClass('is-invalid');
  });

});
