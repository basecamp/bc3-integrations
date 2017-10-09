# Basecamp 3 Integrations

Does your service integrate with the [Basecamp 3 API](https://github.com/basecamp/bc3-api)? Would you like to have it listed on [basecamp.com](https://basecamp.com)? Then you're in the right place.

Your Basecamp 3 integration will be listed at [https://basecamp.com/extras](https://basecamp.com/extras).

## Add Your Integration

To add your integration, please open a pull request.

1. Add your icon file to the [icons/](icons/) folder. Icons must be `256x256` in `.png` format.
2. Add an entry to [integrations.yml](integrations.yml) with your integration's `name`, `description`, `website`, `icon`, and `category` (categories are identified at the top).

  Example:
  ```yaml
  -
    name: "Basecamp 3 App"
    description: "Basecamp 3 for Mac and Windows"
    website: "https://basecamp.com/3/via"
    icon: "basecamp3.png"
    category: 1
  ```



Thank you!
