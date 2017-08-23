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
  <tr>
    <td><tt>['app-nginx']['conf_dir']</tt></td>
    <td>String</td>
    <td>Directory of sites configuration. Best to leave as default.</td>
    <td><tt>'/etc/nginx/sites-available'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-nginx']['priv_dir']</tt></td>
    <td>String</td>
    <td>Convenience directive to create a directory for _private_ files.</td>
    <td><tt>'/etc/nginx/private'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-nginx']['dh_modulus']</tt></td>
    <td>Int</td>
    <td>Length of dhparam file to create for SSL.</td>
    <td><tt>4096</tt></td>
  </tr>
  <tr>
    <td><tt>['app-nginx']['dhparam_path']</tt></td>
    <td>String/Boolean False</td>
    <td>Location of dhparam file. Set to boolean false to prevent creating a dhparam file.</td>
    <td><tt>'/etc/nginx/private/dhparam.pem'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-nginx']['sites']</tt></td>
    <td>Array</td>
    <td>Describes the site name and details for each virtual site created. Every hash element in this array will be passed as variables to a template for the actual config file. To provide a custom template, include the keys :cookbook and :source in the hash. For more details, check the default attributes file of this cookbook.</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['app-nginx']['basic_auth']</tt></td>
    <td>Array</td>
    <td>Describes the credentials to include in htpasswd files, and their locations. Only used by recipe 'basic_auth'. See usage below.</td>
    <td><tt>[]</tt></td>
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

### app-nginx::basic_auth

Creates htpasswd files for basic auth. Populate the needed attributes:

```ruby
default['app-nginx']['basic_auth'] = [ {
  :path => "#{node['app-nginx']['priv_dir']}/mysite.htpasswd",
  :creds => [ {
    :user => 'myuser',
    :pass => 'passwordThatShouldBeInSecretDataBag'
  } ]
} ]
```

Then add `app-nginx::basic_auth` in your node's run_list.

## License and Authors

Author:: Earth U (<iskitingbords @ gmail.com>)
