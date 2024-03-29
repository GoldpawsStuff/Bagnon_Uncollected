# Bagnon_Uncollected Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.0.37-Release] 2023-11-07
- Updated for WoW Client Patch 10.2.0.

## [2.0.36-Release] 2023-10-22
### Fixed
- Fixed faulty embeds that may or may not have caused a startup error.

## [2.0.35-Release] 2023-09-19
- Added TaintLess.xml.

## [2.0.34-Release] 2023-09-06
- Updated for Retail client patch 10.1.7.

## [2.0.33-Release] 2023-07-22
### Changed
- Updated addon listing icon and text format.

## [2.0.32-Release] 2023-07-12
- Bumped to Retail Client Patch 10.1.5.

## [2.0.31-Release] 2023-06-07
### Removed
- Removed the annoying startup message when loaded alongside Bagnon ItemInfo.

## [2.0.30-Release] 2023-05-21
- Cosmetic stuff. Piggybacking.

## [2.0.29-Release] 2023-05-10
- Updated for Bagnon's API for WoW 10.1.0.

## [2.0.28-Release] 2023-05-03
- Updated for WoW 10.1.0.

## [2.0.27-Release] 2023-03-25
- Updated for WoW 10.0.7.

## [2.0.26-Release] 2023-01-26
- Updated for WoW 10.0.5.

## [2.0.25-Release] 2022-12-11
### Fixed
- Changed how bagID is queried to be more consistent across Bagnon updates and versions. A lot of C_Tooltip API errors and general Bagnon lag should be fixed by this.

## [2.0.24-Release] 2022-11-16
- Bump to retail client patch 10.0.2.

## [2.0.23-Release] 2022-10-25
- Bumped retail version to the 10.0.0 patch.

## [2.0.22-Release] 2022-10-13
### Fixed
- Fixed an issue where the wrong bag slot would be queried, resulting in wrong information on the items.

## [2.0.21-RC] 2022-10-12
- Full performance rewrite to take much better advantage of Bagnon and Wildpant's APIs.

## [1.0.20-Release] 2022-08-17
- Bump to client patch 9.2.7.

## [1.0.19-Release] 2022-05-31
- Bump toc to WoW client patch 9.2.5.

## [1.0.18-Release] 2022-02-23
- ToC bump.

## [1.0.17-Release] 2022-02-16
- ToC bumps and license update.

## [1.0.16-Release] 2021-12-12
### Changed
- Added a message when the presence of the addon Bagnon ItemInfo causes this one to be auto-disabled.

## [1.0.15-Release] 2021-11-03
- Bump toc for 9.1.5.

## [1.0.14-Release] 2021-06-29
- Bump toc for 9.1.0.

## [1.0.13-Release] 2021-04-05
- Spring cleaning.

## [1.0.12-Release] 2021-03-10
- Bump to WoW client patch 9.0.5.

## [1.0.11-Release] 2020-11-18
- Bump to WoW Client patch 9.0.2.

## [1.0.10-Release] 2020-10-16
- Bump to WoW Client patch 9.0.1.

## [1.0.9-Release] 2020-09-25
- Cache fixes and Bagnon 9.x compatibility.

## [1.0.8-Release] 2020-08-07
### Changed
- ToC updates.

### Fixed
- Properly disable when Bagnon_ItemInfo is loaded.

## [1.0.7-Release] 2020-01-09
### Fixed
- Fixed for Bagnon 8.2.27, December 26th 2019.

## [1.0.6-Release] 2019-10-08
- ToC updates.

## [1.0.5-Release] 2019-10-08
- Bump to WoW Client patch 8.2.5.
- Fix toc links.

## [1.0.4-Release] 2019-07-02
### Changed
- Updated for 8.2.0.

## [1.0.3-Release] 2019-03-29
### Changed
- Updated addon detection to avoid messing with the addon loading order.
- Updated toc display name to be in line with the main bagnon addon.
- Updated description links and team name.

## [1.0.2-Release] 2019-02-28
### Fixed
- Switched to tooltip scanning using global strings to avoid false positives on uncollected appearances.

## [1.0.1-Release] 2019-02-28
### Fixed
- Fixed an issue that sometimes could cause an "ambigous syntax" error.

## [1.0.0-Release] 2019-02-28
- Initial commit.
