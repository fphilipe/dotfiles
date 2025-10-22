export default {
  defaultBrowser: "Safari",
  rewrite: [
    // Skip Microsoft Office link protection which significantly slows down opening URLs
    {
      match: /https:\/\/(\w+\.safelinks\.protection\.outlook\.com\/|statics\.teams\.cdn\.office\.net\/evergreen-assets\/safelinks\/2\/atp-safelinks.html)/,
      url: url => url.searchParams.get("url") || url
    },
    // Strip UTM parameters
    {
      match: /[?&]utm_\w+=/,
      url: url => {
        const params = url.searchParams;

        for (const key of [...params.keys()]) {
          if (/^utm_/.test(key)) {
            params.delete(key);
          }
        }

        return url
      }
    },
  ],
  handlers: [
    // Open Google products (except search) in Chromium
    {
      match: [/(?<!www)\.google\.com\/.*/, "*.goo.gl/*", "*.google/*"],
      browser: "Chromium"
    },
    // Figma
    {
      match: /www\.figma\.com\/(?!app_auth\/).*/,
      browser: "Figma"
    },
    // Microsoft Teams
    {
      match: "teams.microsoft.com/*",
      browser: "Microsoft Teams"
    },
    // Notion
    {
      match: /www\.notion\.so\/(?!(invoice\/|passkeyauthverify)).*/,
      browser: "Notion"
    },
  ]
}
