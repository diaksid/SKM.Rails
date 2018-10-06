module YandexHelper

  def yandex_metrika_script_tag
    if YANDEX[:metrika]
      content_tag :script do
        <<-JAVASCRIPT.squish.html_safe
        (function (w, d, c, e) {
          d.addEventListener('turbolinks:load', function () {
            (w[c] = w[c] || []).push(function () {
              try {
                w.yaCounter#{YANDEX[:metrika]} = new Ya.Metrika({
                  id: #{YANDEX[:metrika]},
                  clickmap: true,
                  trackLinks: true,
                  accurateTrackBounce: true,
                  webvisor: true,
                  trackHash: true
                })
              } catch (e) {
              }
            })
          });
          e = d.createElement('script');
          e.async = true;
          e.src = 'https://mc.yandex.ru/metrika/watch.js';
          d.head.appendChild(e)
        })(window, document, 'yandex_metrika_callbacks')
        JAVASCRIPT
      end
    end
  end


  def yandex_search_script_tag
    if YANDEX[:search]
      content_tag :script do
        <<-JAVASCRIPT.squish.html_safe
        (function (w, d, n, c, e) {
          d.addEventListener('turbolinks:load', function () {
            e = d.documentElement;
            if (!e.classList.contains(n)) {
              e.classList.add(n)
            }
            (w[c] || (w[c] = [])).push(function () {
              Ya.Site.Form.init()
            })
          });
          e = d.createElement('script');
          e.async = true;
          e.src = 'https://site.yandex.net/v2.0/js/all.js';
          d.head.appendChild(e)
        })(window, document, 'ya-page_js_yes', 'yandex_site_callbacks');
        JAVASCRIPT
      end
    end
  end

end
