window.addEventListener("load", () => {
  if (location.pathname === "/common/oauth2/v2.0/authorize") {
    setInterval(() => {
      const rows = document.querySelectorAll(".table-row");
      if (rows.length === 2)
        rows[0].click();
    }, 500);
  }
});
