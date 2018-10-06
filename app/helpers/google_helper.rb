module GoogleHelper

  def google_analytics_script_tag
    if GOOGLE[:analytics]
      content_tag :script do
        <<-JAVASCRIPT.squish.html_safe
          (function(b,o,i,l,e,r) {
            b.GoogleAnalyticsObject = l;
            b[l] || (b[l] = function() { (b[l].q = b[l].q || []).push(arguments); });
            b[l].l =+ new Date;
            e = o.createElement(i);
            r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)
          }(window,document,'script','ga'));
          ga('create',#{GOOGLE[:analytics]},'auto');
          ga('send','pageview');
        JAVASCRIPT
      end
    end
  end

end
