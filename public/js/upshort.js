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

});
