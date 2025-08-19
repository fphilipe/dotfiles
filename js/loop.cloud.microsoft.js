const url = new URL(window.location.href);
const params = url.searchParams;
const locale = params.get("locale");

if (locale === null || locale.toLowerCase() !== "en-us") {
  params.set("locale", "en-us");
  url.search = params.toString();
  window.location.replace(url.toString());
}
