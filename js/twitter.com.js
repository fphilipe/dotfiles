const blacklist = ['promoted']

function removeCrap() {
  const ads = Array.from(
    new Set(
      Array.from(document.querySelectorAll('span')).map(
        e => e.parentNode
      )
    )
  )
    .filter(e => {
      const text = e.innerText.toLowerCase()
      return blacklist.some(badWord => text.indexOf(badWord) >= 0)
    })
    .map(e => e.closest('article'))

  console.log(`Removing ${ads.length} blacklisted elements`)

  ads.forEach(e => e.remove())
}

const observer = new MutationObserver(domChanged)

function domChanged() {
  observer.disconnect()
  removeCrap()
  observer.observe(document.body, {
    childList: true,
    subtree: true,
  })
}

domChanged()
