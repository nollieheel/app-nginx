# app_nginx cookbook

A wrapper cookbook that installs Nginx webserver pre-configured for common usage. Also adds `app_nginx_auth_file` resource.

## Supported Platforms

Ubuntu 20.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['app_nginx']['worker_processes']</tt></td>
    <td>Int, String</td>
    <td>**</td>
    <td><tt>'auto'</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['worker_connections']</tt></td>
    <td>Int</td>
    <td>**</td>
    <td><tt>1_024</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['sendfile']</tt></td>
    <td>String</td>
    <td>**</td>
    <td><tt>'on'</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['tcp_nopush']</tt></td>
    <td>String</td>
    <td>**</td>
    <td><tt>'on'</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['tcp_nodelay']</tt></td>
    <td>String</td>
    <td>**</td>
    <td><tt>'on'</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['keepalive_timeout']</tt></td>
    <td>Integer</td>
    <td>**</td>
    <td><tt>30</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['conf_variables']</tt></td>
    <td>Hash</td>
    <td>Additional settings for Nginx config</td>
    <td><tt>See default attributes file</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['auth_file']</tt></td>
    <td>Array</td>
    <td>Can be used to automatically create basic auth files with the default recipe</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

** See `nginx_config` [documentation](https://github.com/sous-chefs/nginx/blob/12.0.12/documentation/nginx_config.md)

## Usage

### app_nginx::default

To install, configure, and enable the nginx service, include `app_nginx::default` recipe in your node's run_list.

### app_nginx_auth_file

Create a basic auth file:

```ruby
app_nginx_auth_file '/etc/nginx/.htpasswd' do
  users [
    {user: 'john', pass: 'secret'},
    {user: 'jane', pass: 'password'},
  ]
end
```

## Creating a Site

To create a site, use the standard `nginx_site` resource as described in cookbook [`nginx`](https://github.com/sous-chefs/nginx/blob/12.0.12/documentation/nginx_site.md).

An example site template is included in this repo (app_nginx) for usage or reference: [site-template.erb](templates/default/site-template.erb).

## License and Authors

Author:: Earth U (<iskitingbords@gmail.com>)
