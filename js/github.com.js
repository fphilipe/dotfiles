document.addEventListener("turbo:load", (event) => {
  if (!/\/enterprises\/[^/]+\/settings\/security$/.test(location.pathname)) {
    const notice = document.evaluate(
      "//button[contains(., 'Single sign-on')]",
      document,
      null,
      XPathResult.FIRST_ORDERED_NODE_TYPE,
      null
    ).singleNodeValue;

    if (notice) {
      notice?.click();
      setTimeout(() => {
        document.activeElement.click()
      }, 0)
    } else {
      document.querySelector("a[href*='/sso']")?.click()
      document.querySelector("form[action*='/saml/initiate']")?.requestSubmit()
    }
  }
})
