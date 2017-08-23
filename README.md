# app-nginx cookbook

A wrapper cookbook that installs Nginx webserver.

## Supported Platforms

Ubuntu 14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
</table>

## Usage

### app-nginx::default

Include `app-nginx` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[app-nginx::default]"
  ]
}
```

## License and Authors

Author:: Earth U (<iskitingbords @ gmail.com>)
