# Configuration

Every package below expects the including config to provide what
[`examples/common/base.yaml`](../examples/common/base.yaml) does: `wifi:`
with `id: wifi_id`, `api:` with `id: ha_api`, and a `time:` clock with
`id: canonical_time`. Display packages also need a bus or display the
example declares.

Fonts and images live in `packages/assets/`. ESPHome resolves their paths
relative to the device config, so the display packages take the directory
as a substitution (`exit_poll_assets` or `appliances_assets`, default
`../packages/assets`, right for configs in `examples/`).

## `packages/exit-poll.yaml`

Mirrors 16 counts from Home Assistant (four sections × doors open, doors
unlocked, AV on, water running), totals them, and publishes **System
Status**: 0 all good, 1 no Wi-Fi, 2 no Home Assistant, 3 AV on or water
running, 4 a door open or unlocked. Also a **Current Time** text sensor and
`debug:` at 5 s.

**Requires:** `wifi_id`, `api:`, `canonical_time`.

**Provides:** `section_N_doors_open`, `section_N_doors_unlocked`,
`section_N_av_on`, `section_N_water_running` (N = 1..4), `total_*`,
`system_status`, and the globals `wireguard_present` / `wireguard_connected`.

| Substitution | Default | Meaning |
|--------------|---------|---------|
| `exit_poll_section_N_doors_open_entity` | `sensor.total_section_N_doors_open` | HA entity for section N's open-door count |
| `exit_poll_section_N_doors_unlocked_entity` | `sensor.total_section_N_doors_unlocked` | HA entity for section N's unlocked-door count |
| `exit_poll_section_N_av_on_entity` | `sensor.total_section_N_av_on` | HA entity for section N's AV-on count |
| `exit_poll_section_N_water_running_entity` | `sensor.total_section_N_water_running` | HA entity for section N's running-water count |
| `exit_poll_update_interval` | `1s` | How often totals and status are recomputed |

To show a WireGuard tunnel's state on the display, add the tunnel and copy
its status into the globals:

```yaml
binary_sensor:
  - platform: wireguard
    status:
      name: "WireGuard Connected"
      id: wireguard_online

interval:
  - interval: 1s
    then:
      - lambda: |-
          id(wireguard_present) = true;
          id(wireguard_connected) = id(wireguard_online).state;
```

```yaml
packages:
  exit_poll: github://romkey/pdxhackerspace-exit-poll/packages/exit-poll.yaml@v0.4.0
```

## `packages/exit-poll-leds.yaml`

An addressable LED strip showing System Status as a color, a master **LEDs**
switch, an **LED Manual Override** switch, and buttons for fixed colors and
effects. ESP32-family chips only (`esp32_rmt_led_strip`).

**Requires:** `exit-poll.yaml`, `exit_poll_leds_pin`.

| Substitution | Default | Meaning |
|--------------|---------|---------|
| `exit_poll_leds_pin` | (required) | Data GPIO |
| `exit_poll_leds_chipset` | `WS2812` | LED chipset |
| `exit_poll_leds_rgb_order` | `GRB` | Color order |
| `exit_poll_leds_count` | `8` | Number of LEDs |

```yaml
substitutions:
  exit_poll_leds_pin: GPIO7

packages:
  exit_poll_leds: github://romkey/pdxhackerspace-exit-poll/packages/exit-poll-leds.yaml@v0.4.0
```

## `packages/exit-poll-lcars-320x480.yaml`

The LCARS screen on a 320x480 portrait SPI panel (mipi_spi): clock, Wi-Fi and
WireGuard icons, and each section's four counts.

**Requires:** `exit-poll.yaml`, an `spi:` bus, and the pins below.

| Substitution | Default | Meaning |
|--------------|---------|---------|
| `exit_poll_lcars_model` | (required) | mipi_spi model, e.g. `ILI9488`, `ST7796` |
| `exit_poll_lcars_cs_pin` | (required) | Display CS |
| `exit_poll_lcars_dc_pin` | (required) | Display DC |
| `exit_poll_lcars_reset_pin` | (required) | Display reset |
| `exit_poll_lcars_color_depth` | `16` | `8` on boards without PSRAM |
| `exit_poll_lcars_spi_id` | `spi_bus` | spi bus id |
| `exit_poll_assets` | `../packages/assets` | Fonts and images directory |

```yaml
substitutions:
  exit_poll_lcars_model: ILI9488
  exit_poll_lcars_cs_pin: GPIO2
  exit_poll_lcars_dc_pin: GPIO4
  exit_poll_lcars_reset_pin: GPIO3

spi:
  id: spi_bus
  clk_pin: GPIO9
  mosi_pin: GPIO36
  miso_pin: GPIO8

packages:
  exit_poll_lcars: github://romkey/pdxhackerspace-exit-poll/packages/exit-poll-lcars-320x480.yaml@v0.4.0
```

## `packages/exit-poll-lvgl-480x800.yaml`

The LCARS screen in LVGL for an 800x480 panel rotated to 480x800 portrait.
LVGL does the rotation (it also rotates touch), so the display must not set
one.

**Requires:** `exit-poll.yaml`, an 800x480 display and a touchscreen.

| Substitution | Default | Meaning |
|--------------|---------|---------|
| `exit_poll_lvgl_display_id` | `main_display` | Display id |
| `exit_poll_lvgl_touchscreen_id` | `touchscreen0` | Touchscreen id |
| `exit_poll_assets` | `../packages/assets` | Fonts directory |

```yaml
packages:
  exit_poll_lvgl: github://romkey/pdxhackerspace-exit-poll/packages/exit-poll-lvgl-480x800.yaml@v0.4.0
```

See [`examples/guition-8048s550.yaml`](../examples/guition-8048s550.yaml) for
a matching display and touchscreen.

## `packages/appliances.yaml`

Mirrors appliance remaining-time sensors (seconds) from Home Assistant.

**Requires:** nothing.

| Substitution | Default | Meaning |
|--------------|---------|---------|
| `appliances_washer_entity` | `sensor.canonical_washer_remaining_seconds` | Washer |
| `appliances_dryer_entity` | `sensor.canonical_dryer_remaining_seconds` | Dryer |
| `appliances_dishwasher_entity` | `sensor.canonical_dishwasher_remaining_seconds` | Dishwasher |
| `appliances_oven_entity` | `sensor.canonical_oven_remaining_seconds` | Oven |
| `appliances_printer_entity` | `sensor.canonical_printer_remaining_seconds` | 3D printer |

```yaml
packages:
  appliances: github://romkey/pdxhackerspace-exit-poll/packages/appliances.yaml@v0.4.0
```

## `packages/appliances-grid-480x320.yaml` and `packages/appliances-2-line-480x320.yaml`

Appliance screens for a 480x320 landscape SPI panel. The grid shows all five
appliances and a clock; the 2-line layout shows a clock above large washer
and dryer rows, and adds a **Clock Colon Blink** switch. A finished
appliance shows a check mark that flashes for 3 minutes.

**Requires:** `appliances.yaml`, an `spi:` bus, the pins below; the 2-line
layout also uses `ha_api`.

| Substitution | Default | Meaning |
|--------------|---------|---------|
| `appliances_display_model` | (required) | mipi_spi model |
| `appliances_display_cs_pin` | (required) | Display CS |
| `appliances_display_dc_pin` | (required) | Display DC |
| `appliances_display_reset_pin` | (required) | Display reset |
| `appliances_display_rotation` | `90` | Rotation that makes the panel 480x320 |
| `appliances_display_color_depth` | `16` | `8` on boards without PSRAM |
| `appliances_display_spi_id` | `spi_bus` | spi bus id |
| `appliances_assets` | `../packages/assets` | Fonts directory |

```yaml
packages:
  appliances_display: github://romkey/pdxhackerspace-exit-poll/packages/appliances-grid-480x320.yaml@v0.4.0
```
