let count = 0

function removePromoted() {
  console.log('Checking for promoted tweets')

  const promoted = document.evaluate(
    "//span[text() = 'Promoted']",
    document,
    null,
    XPathResult.ANY_TYPE,
    null
  )

  let node = promoted.iterateNext()
  if (!node) return

  count += 1
  do {
    node = node.parentNode.closest('div')
  } while (node.attributes.length > 0)
  node.style.display = 'none'
  console.log(`Removed ${count} promoted tweets so far`)
}

const observer = new MutationObserver(domChanged)

function domChanged() {
  removePromoted()
  observer.observe(document.body, {
    childList: true,
    subtree: true,
  })
}

domChanged()
