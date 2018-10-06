module JsEventsHelper

  def js_events_script_tag
    content_tag :script do
      <<-JAVASCRIPT.squish.html_safe
      (function (w, d) {
        d.documentElement.className = 'is-js is-touch'
          + (w.ontouchstart || (w.DocumentTouch && d instanceof DocumentTouch) ? '' : '--not')
          + ((/msie|rv:11/i).test(navigator.userAgent) ? ' is-ie' : '')
      })(window, document)
      JAVASCRIPT
    end
  end

end
