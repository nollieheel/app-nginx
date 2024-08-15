# app_nginx CHANGELOG

## 5.2.2 - 2024-08-16
### Fixed
- Nginx logging to ".log.1" instead of ".log" after a logrotate

## 5.2.1 - 2024-08-11
### Fixed
- Missing template error

## 5.2.0 - 2024-08-11
### Added
- Added app_nginx_repo resource to give an option of loading the repo separately

## 5.1.0 - 2024-05-12
### Changed
- Skipped adding repo from `nginx` community cookbook

## 5.0.0 - 2024-05-10
### Breaking changes
- Removed support for Ubuntu 20.04

### Added
- Overwrote nginx repo listing in apt

## 4.0.1 - 2023-05-06
### Removed
- Non-standard X-XSS-Protection header from sample site templates.

## 4.0.0 - 2022-11-17
### Changed
- Upgraded nginx cookbook dependency for security fixes.
- log_location is no longer the name property of app_nginx_log_perms resource.

### Added
- Update README.md
- Tests

## 3.2.0 - 2022-10-11
### Changed
- Bumped nginx version dependency for bug fixes.
- Reverted all default names/owners and groups from 'nginx' to 'www-data'.

## 3.1.0 - 2022-07-19
### Added
- Resource 'app_nginx_log_perms'. This fixes log file permissions issues post-install.

## 3.0.2 - 2022-06-07
### Fixed
- Nginx worker cannot read .htpasswd file for basic auth.

## 3.0.1 - 2021-11-12
### Changed
- Set basic auth file permissions to 0640

## 3.0.0 - 2021-10-21
### Changed
- Bunch of BREAKING changes
- Renamed cookbook to `app_nginx`.
- Made compatible with Chef 17.x

## 2.0.1 - 2020-04-01
### Fixed
- Logrotate bug in Ubuntu 16.04 where new files are created under user 'nginx', with 'www-data' not being able to write to them.

## 2.0.0 - 2018-12-03
### Added
- Support for Ubuntu 16.04.
- Test.

### Changed
- Update dependent cookbooks.
- More open version restriction for dependent cookbooks.
- Attribute `worker_processes` now default to 1 + number of CPUs.

### Removed
- Removed `basic_auth` recipe. It is now integrated with `configure` recipe.
- Removed an unnecessary wrapped attribute for Ubuntu 14.04.

## 1.0.0 - 2018-02-20
- Breaking changes!
- Updated dependency versions for both cookbooks and Chef client itself.

## 0.1.0 - 2017-08-30
### Added
- Initial working version of the cookbook

---
Changelog format reference: http://keepachangelog.com/en/0.3.0/
