# PDX Hackerspace Exit Poll overview

**What:** a door-side display showing from Home Assistant whether doors are
open or unlocked, water is running or AV is on, plus a sibling appliance
countdown display.
**Kind:** app.
**Hardware:** TinyS3 (ESP32-S3) on the Exit Poll PCB with a 320x480
ILI9488; Hosyond 4" CYD (ESP32, ST7796); Guition 8048S550 (ESP32-S3, 800x480
RGB, GT911 touch at 0x5D); TinyPICO (ESP32) with a 480x320 ILI9488. Optional
WS2812 LED strip.

## Files

- `packages/exit-poll.yaml`: HA counts, totals, System Status (no UI).
- `packages/exit-poll-leds.yaml`: LED strip status color and overrides.
- `packages/exit-poll-lcars-320x480.yaml`: LCARS screen, SPI mipi_spi.
- `packages/exit-poll-lvgl-480x800.yaml`: LCARS screen, LVGL portrait.
- `packages/appliances.yaml`: HA appliance remaining-time sensors.
- `packages/appliances-grid-480x320.yaml`: five-appliance grid screen.
- `packages/appliances-2-line-480x320.yaml`: washer/dryer two-row screen.
- `packages/assets/`: fonts and LCARS PNGs.
- `examples/*.yaml`: one per board; all board/pin choices. ESP32 and S3
  only (no C3 board in this project).
- `examples/common/base.yaml`: project, network, recovery, SNTP clock.
- `examples/common/hosyond-4in-cyd-board.yaml`: Hosyond board, shared by
  two examples.
- `examples/local-*.yaml`: personal device configs, gitignored.
- `pcb/`, `case/`, `lcars/`: hardware and art sources, not ESPHome.

## Required by packages

- Ids: `wifi_id` (wifi), `ha_api` (api), `canonical_time` (time),
  `spi_bus` (SPI displays), `i2c0` (i2c-scan from esphome-lib).
- Substitutions: display pins (`*_cs_pin`, `*_dc_pin`, `*_reset_pin`,
  `*_model`) and `exit_poll_leds_pin`.

## Conventions

- Substitutions prefixed with package name; all have defaults unless listed
  above.
- Entity names and ids are fixed, not substitutions: the UI packages share
  them, nothing is included twice, and renames lose HA history.
- Clock is SNTP, not Home Assistant, so it works when HA is down.
- Rules: https://github.com/romkey/esphome-ai-coding-rules/blob/main/RULES.md
