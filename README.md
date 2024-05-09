# app_nginx cookbook

A wrapper cookbook that installs Nginx webserver pre-configured for common usage. Also adds `app_nginx_auth_file` and `app_nginx_log_perms` resources.

## Supported Platforms

LTS version of Ubuntu >= 22.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['app_nginx']['process_user']</tt></td>
    <td>String</td>
    <td>**</td>
    <td><tt>'www-data'</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['process_group']</tt></td>
    <td>String</td>
    <td>**</td>
    <td><tt>'www-data'</tt></td>
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
    <td><tt>60</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['types_hash_max_size']</tt></td>
    <td>Integer</td>
    <td>**</td>
    <td><tt>2_048</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['conf_cookbook']</tt></td>
    <td>String</td>
    <td>**</td>
    <td><tt>'app_nginx'</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['conf_template']</tt></td>
    <td>String</td>
    <td>**</td>
    <td><tt>'nginx.conf.erb'</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['conf_variables']</tt></td>
    <td>Hash</td>
    <td>**</td>
    <td><tt>(See default attributes file)</tt></td>
  </tr>
  <tr>
    <td><tt>['app_nginx']['auth_file']</tt></td>
    <td>Array</td>
    <td>Can be used to automatically create basic auth files with the default recipe</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

** These attributes are fed directly into `nginx_config` as resource properties. See [documentation](https://github.com/sous-chefs/nginx/blob/12.2.9/documentation/nginx_config.md).

## Recipes

### app_nginx::default

To install, configure, and enable the nginx service, include `app_nginx::default` recipe in your node's run_list. Basic auth files are also optionally created.

## Resources

### app_nginx_auth_file

Create a basic auth file:

```ruby
app_nginx_auth_file '/etc/nginx/htpasswd' do
  users [
    {user: 'john', pass: 'secret'},
    {user: 'jane', pass: 'password'},
  ]
end
```

#### Actions

- `create` - Create the basic auth file

#### Properties

- `path` - Desired location of basic auth file. Defaults to name of resource.
- `users` - Array of user-pass hashes. Default: `[]`.

### app_nginx_log_perms

Run this resource to fix the log files permissions and update logrotate config after Nginx has been installated and sites have been created.

```ruby
app_nginx_log_perms 'logs' do
  initial_log_files [
    'access.log',
    'error.log',
    'mydomain.access.log',
    'mydomain.error.log',
  ]
end
```

#### Actions

- `fix` - Perform the fixes (default)

#### Properties

- `initial_log_files` - List of log filenames to be created initially in the dirname of `log_location`. Add all sites' log filenames to this array. Default: `['access.log', 'error.log']`.
- `log_location` - Location of log files of Nginx installation. Default: `/var/log/nginx/*.log`.
- `owner` - Owner of log files of Nginx installation. Default: `node['app_nginx']['process_user']`.
- `pid_file` - Location of pid file of Nginx installation. Default: `/var/run/nginx.pid`.
- `log_config_location` - Location of logrotate config file. Default: `/etc/logrotate.d/nginx`.

## Creating a Site

To create a site, use the standard `nginx_site` resource as described in cookbook [`nginx`](https://github.com/sous-chefs/nginx/blob/12.2.9/documentation/nginx_site.md).

An example site template is included in this repo (app_nginx) for usage or reference: [site-template.erb](templates/default/site-template.erb).

## License and Authors

Author:: Earth U (<iskitingbords@gmail.com>)
