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
    <td><tt>['app-nginx']['priv_dir']</tt></td>
    <td>String</td>
    <td>Convenience directive to create a directory for _private_ files.</td>
    <td><tt>'/etc/nginx/private'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-nginx']['dh_modulus']</tt></td>
    <td>Int</td>
    <td>Length of dhparam file to create for TLS.</td>
    <td><tt>4096</tt></td>
  </tr>
  <tr>
    <td><tt>['app-nginx']['dhparam_path']</tt></td>
    <td>String/Boolean False</td>
    <td>Location of dhparam file. Set to boolean false to prevent creating a dhparam file.</td>
    <td><tt>'/etc/nginx/private/dhparam.pem'</tt></td>
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

## Creating a Site

To create a site, use the standard `nginx_site` resource as described in cookbook [`nginx`](https://github.com/chef-cookbooks/nginx). To quote:

### nginx_site

Enable or disable a Server Block in `#{node['nginx']['dir']}/sites-available` by calling nxensite or nxdissite (introduced by this cookbook) to manage the symbolic link in `#{node['nginx']['dir']}/sites-enabled`.

### Actions

- `enable` - Enable the nginx site (default)
- `disable` - Disable the nginx site

### Properties:

- `name` - (optional) Name of the site to enable. By default it's assumed that the name of the nginx_site resource is the site name, but this allows overriding that.
- `template` - (optional) Path to the source for the `template` resource.
- `cookbook` - (optional) The cookbook that contains the template source.
- `variables` - (optional) Variables to be used with the `template` resource

An example site template is included in this repo (app-nginx): [site.conf.erb](templates/default/site.conf.erb).

## License and Authors

Author:: Earth U (<iskitingbords @ gmail.com>)
