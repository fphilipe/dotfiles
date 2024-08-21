document.addEventListener("turbo:load", (event) => {
  if (window.location.pathname.match(/^\/enterprises\/[a-z0-9-_]+\/sso$/) && document.forms.length === 1) {
    document.forms[0].requestSubmit()
  }
})
