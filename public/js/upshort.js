//
// upshort javascript fancypants
//
$(function() {

  // uploader widget
  $('.form-upload .btn-file :file').on('change', function() {
    var label = $(this).val().replace(/\\/g, '/').replace(/.*\//, '');
    $('.form-upload :text').val(label);
    $('.form-upload .submit').removeClass('disabled');
    $('.form-upload .submit button').removeAttr('disabled');
  });
  $('.form-upload').on('submit', function() {
    if ($('.form-upload :file').val()) {
      $('.form-upload .submit button').html('Shorts-ing...').attr('disabled', 'disabled');
      $('.form-upload .glyphicon').addClass('spin');
    }
    else {
      return false; // nothing selected
    }
  });

  // deleter
  $('.short-all .thumbnail .delete').on('click', function() {
    $(this).closest('.thumbnail').addClass('deleting');
  });
  $('.short-all .alert-danger .btn-default').on('click', function() {
    $(this).closest('.thumbnail').removeClass('deleting');
  });
  $('.short-all .alert-danger .btn-danger').on('click', function() {
    $.ajax({type: 'DELETE', url: '/' + $(this).closest('.thumbnail').data('short')});
    $(this).closest('.thumbnail').parent().fadeOut(200, function() { $(this).remove(); });
  });

});
