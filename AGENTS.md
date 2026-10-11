# Instructions for AI assistants

Follow https://github.com/romkey/esphome-ai-coding-rules/blob/main/RULES.md.
With Claude Code, the `esphome-rules` plugin loads them for you.

Read docs/overview.md first. `main` is protected: work on a branch and
open a pull request; CI and Lint must pass before it can merge.

<!-- Project-specific notes go below. -->

- This is an app. Two displays share the repo: Exit Poll (`exit-poll*`
  packages) and the appliance countdown (`appliances*`).
- Deliberate deviations from the rules: entity names and ids in packages
  are fixed rather than substitutions (UI packages reference them, nothing
  is included twice, renames lose HA history); the clock is SNTP, not
  homeassistant; there is no ESP32-C3 example (no C3 board in the project).
- Display packages find fonts/images via `exit_poll_assets` /
  `appliances_assets`, because ESPHome resolves paths relative to the
  device config, not the package.
