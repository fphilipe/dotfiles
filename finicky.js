export default {
  defaultBrowser: "Safari",
  rewrite: [
    // Skip Outlook link protection which significantly slows down opening URLs
    {
      match: "*.safelinks.protection.outlook.com/*",
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
      match: "www.figma.com/*",
      browser: "Figma"
    },
    // Microsoft Teams
    {
      match: "teams.microsoft.com/*",
      browser: "Microsoft Teams"
    },
    // Notion
    {
      match: "www.notion.so/*",
      browser: "Notion"
    },
  ]
}
