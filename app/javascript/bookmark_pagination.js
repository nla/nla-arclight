const refreshBookmarks = () => {
  const url = new URL(window.location.href)
  const page = Number(url.searchParams.get('page')) || 1

  // Removing the last displayed record can leave the current page out of range.
  if (document.querySelectorAll('#documents .document').length === 1 && page > 1) {
    url.searchParams.set('page', page - 1)
  }

  window.location.replace(url.toString())
}

const watchBookmarkRemoval = () => {
  if (!document.body.classList.contains('blacklight-bookmarks-index')) return

  // This frontend version has no bookmark success event. The method changes
  // from delete to put only after the server confirms successful removal.
  document.querySelectorAll('#documents form.bookmark-toggle input[name="_method"][value="delete"]').forEach(input => {
    const observer = new MutationObserver(() => {
      if (input.value !== 'put') return
      observer.disconnect()
      refreshBookmarks()
    })
    observer.observe(input, { attributes: true, attributeFilter: ['value'] })
  })
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', watchBookmarkRemoval, { once: true })
} else {
  watchBookmarkRemoval()
}
