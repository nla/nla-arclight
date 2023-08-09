import "@hotwired/turbo-rails"
import "controllers"

Turbo.session.drive = false

$(function() {
  let blacklightModal = $('#blacklight-modal');
  let modalObserver = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      const newNodes = mutation.addedNodes;
      if (newNodes !== null) {
        let plotConfig = blacklightModal.find('.blrl-plot-config');
        if (plotConfig) {
          plotConfig.data('plot-config', {
            selection: { color: '#46474A' },
            colors: ['#ffffff'],
            series: { lines: { fillColor: 'rgba(112,57,150, 0.8)' }},
            grid: { color: '#677078', tickColor: '#f4f5f6', borderWidth: 1 }
          });
        }
      }
    });
  });
  let observerConfig = {
    childList: true,
    subtree: true
  }
  modalObserver.observe(blacklightModal[0], observerConfig);
});

Blacklight.onLoad(function() {

  /* Searching within a collection should not yield results */
  /* grouped by collection. */

  $('form.search-query-form').submit(() => {
    if ($('select#within_collection').val()) {
      $('input#group').remove();
    }
  });
});
