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
