# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[Semantic Versioning](https://semver.org/).

## [Unreleased]

### Changed

- **Breaking:** restructured to follow
  [esphome-ai-coding-rules](https://github.com/romkey/esphome-ai-coding-rules).
  `esphome/` is gone: board-independent packages are in `packages/`, board
  configs in `examples/`. Remote includes of `esphome/*.yml` must move to
  `packages/*.yaml`.
- **Breaking:** substitutions renamed with their package's prefix
  (`led_data_pin` → `exit_poll_leds_pin`, `display_model` →
  `exit_poll_lcars_model` or `appliances_display_model`, etc.); bus pins
  are now set directly in the examples.
- **Breaking:** OTA uses encryption with the API key instead of a password;
  secrets renamed (`api_key` → `api_encryption_key`, `wifi_ap_password` →
  `fallback_ap_password`) and `web_server_username`/`web_server_password`
  added.
- The web server requires a password and no longer accepts firmware uploads.
- TinyS3 and TinyPICO examples use esp-idf instead of Arduino.
- esphome-lib packages pinned to v0.2.0 instead of `main`.
- Project name is `romkey.pdxhackerspace-exit-poll` for all devices.

### Added

- Home Assistant entity ids for every count are substitutions.
- Examples for the Hosyond board with the appliance display and for the
  Guition board with logs on its USB port.
- Safe mode and factory reset buttons, I2C scan, `min_version`.
- Docker Compose services, GitHub CI/lint/release workflows, pre-commit
  hooks, Renovate, docs, AGENTS.md and SECURITY.md.

### Removed

- The duplicate Restart button (esphome-lib's replaces it, same name).
