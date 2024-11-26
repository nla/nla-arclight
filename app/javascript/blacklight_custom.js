$(function() {
  BlacklightRangeLimit.turnIntoPlot = function turnIntoPlot(container, wait_for_visible) {
    // flot can only render in a div with a defined width.
    // for instance, a hidden div can't generally be rendered in (although if you set
    // an explicit width on it, it might work)
    //
    // We'll count on later code that catch bootstrap collapse open to render
    // on show, for currently hidden divs.

    // for some reason width sometimes return negative, not sure
    // why but it's some kind of hidden.
    if (container.width() > 0) {
      var height = container.width() * BlacklightRangeLimit.display_ratio;

      // Need an explicit height to make flot happy.
      container.height( height )

      $('.blrl-plot-config').each(function() {
        $(this).data('plot-config', {
          selection: { color: '#685E57' },
          colors: ['#ffffff'],
          series: { lines: { fillColor: '#a1d6ca' }},
          grid: { color: '#677078', tickColor: '#f4f5f6', borderWidth: 1 }
        });
      });

      BlacklightRangeLimit.areaChart($(container));

      $(container).trigger(BlacklightRangeLimit.redrawnEvent);
    }
    else if (wait_for_visible > 0) {
      setTimeout(function() {
        BlacklightRangeLimit.turnIntoPlot(container, wait_for_visible - 50);
      }, 50);
    }
  }
});
