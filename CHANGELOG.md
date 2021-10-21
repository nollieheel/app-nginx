# app_nginx CHANGELOG

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
