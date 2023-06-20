import "@hotwired/turbo-rails"
import "controllers"

Turbo.session.drive = false

Blacklight.onLoad(function() {

  /* Searching within a collection should not yield results */
  /* grouped by collection. */

  $('form.search-query-form').submit(() => {
    if ($('select#within_collection').val()) {
      $('input#group').remove();
    }
  });
});
