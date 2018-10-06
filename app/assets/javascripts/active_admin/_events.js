(function($) {
  $(function () {
    $('#utils > a').html('&hellip;')

    $('.has-upload_icon, .has-attachment').each(function () {
      var obj = $(this)
      if (!obj.find('[type="file"]').length) {
        obj.find('.handle').show()
      }
    })

    autosize(document.querySelectorAll('textarea.h-autosize'))
  })
}).call(this, $)
