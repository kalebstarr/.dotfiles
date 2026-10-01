# ThinkPad configuration review

This file tracks decisions from the feature-by-feature review. An agreed
preference is a plan, not permission to edit or activate the configuration.
Configuration changes require the user's permission after explaining why and
where they will be made. The user has authorized creating and maintaining this log.

## Scope

- Review host configuration first, starting with the ThinkPad.
- Review shared and ThinkPad-specific Home Manager configuration later.
- Consider effects on WSL before changing shared modules or flake wiring.
- Identify defaults to preserve as each feature is discussed.
- The user has now authorized beginning the feature-by-feature Home Manager
  review. This remains planning only; configuration edits still need approval.

## Agreed decisions

### Window management

- Keep Niri unchanged; the user likes its window-management behavior.
- Preserve `programs.niri.enable = true` in `hosts/thinkpad/desktop.nix`.
- Any later DMS session integration must be discussed separately.

### Login screen

- Keep greetd and replace ReGreet with DankGreeter.
- Synchronize DankGreeter with the user's DMS theme and wallpaper.
- Preserve none of the current ReGreet customizations: remove its greeting,
  wallpaper override, clock configuration, font, GTK theme, cursor theme, and CSS.
- Main affected file: `hosts/thinkpad/default.nix`, which currently contains
  the greetd and ReGreet configuration.
- Purpose: use the requested DMS-integrated login screen and remove the existing
  custom styling.
- Before implementation, verify module/package availability in the pinned
  nixpkgs and the configuration and file-access requirements for theme sync.
- Normal password login is the planned flow; automatic login is not requested.

### Credential storage and login unlocking

- Use GNOME Keyring with automatic unlocking at password login.
- The login keyring password must match the account's login password for this
  flow. Existing keyring state has not been inspected.
- Purpose: let compatible applications store credentials and retrieve them
  after login without an additional keyring password prompt.
- Pinned-source inspection confirms Niri enables GNOME Keyring by default;
  the keyring module enables login PAM integration, and greetd delegates to the
  login PAM stack. Avoid redundant PAM overrides. Effective configuration and
  actual unlocking still need verification during implementation.
- Potential affected files: `hosts/thinkpad/desktop.nix` for the service and
  `hosts/thinkpad/default.nix` for greetd login integration, if changes are needed.
- Installing Seahorse, changing SSH-agent behavior, and adding fingerprint or
  security-key authentication have not been agreed.

### Screen locking

- Use DMS's lock screen with account-password authentication managed through
  NixOS's PAM configuration.
- Purpose: integrate locking with DMS and keep authentication declarative.
- Affected host file: `hosts/thinkpad/desktop.nix`; configure the authentication
  support required by the selected DMS module/version and remove the current
  swaylock PAM declaration once the replacement is integrated.
- Lock shortcuts and session startup changes are part of the Home Manager
  review. Agreed sleep and idle behavior is recorded in the relevant sections.

### DMS and DankGreeter package sources

- Use the native nixpkgs packages and NixOS modules for DMS and DankGreeter.
- Purpose: keep their versions tied to the existing nixpkgs update workflow,
  without adding separate upstream flake inputs.
- Verify that the pinned nixpkgs revision supports the agreed features before
  implementation. A nixpkgs update has not been authorized.
- Primary affected files: `hosts/thinkpad/desktop.nix` for DMS and
  `hosts/thinkpad/default.nix` for DankGreeter.
- Session integration and optional DMS features remain to be reviewed.

### File manager

- Use Nautilus with a minimal setup for local files.
- Do not add the proposed GVfs/UDisks2 service setup for removable-drive or
  network-share integration. This does not require removing dependencies or
  services that other features already need.
- Purpose: provide a local graphical file manager without requesting extra
  storage services.
- Recommended placement: `home/thinkpad.nix` via `home.packages`, with folder
  associations and shortcuts handled during the later Home Manager review.
  The earlier proposal to install Nautilus in the host package list is superseded.
- Host-level desktop portals and D-Bus integration remain a separate topic.
  Current upstream nixpkgs's Niri module registers Nautilus for its file chooser
  by default; verify the pinned module before proposing additional host settings.

### Desktop portals

- Retain GNOME for screen sharing, GTK for fallback functionality, and use
  Nautilus-backed portal file dialogs.
- Prefer Niri's supplied portal defaults. Simplify the explicit `xdg.portal`
  block in `hosts/thinkpad/desktop.nix` only after verifying which settings the
  pinned modules already supply and checking the effective configuration.
- Purpose: preserve normal application integration with less custom host
  configuration. This does not add the declined GVfs storage setup.

### Audio

- Keep PipeWire, WirePlumber, ALSA and PulseAudio compatibility, and RTKit.
- Keep the separate PulseAudio server disabled.
- Drop JACK compatibility: the user listens to music, watches videos, and uses
  ordinary desktop audio; they do not do music production.
- Affected file: `hosts/thinkpad/desktop.nix`; remove `jack.enable = true`
  and verify that the effective setting is disabled.
- Purpose: preserve normal audio support while removing unused JACK support.
- Audio-control applications and keybindings remain for the home review/DMS
  session integration.

### Bluetooth

- Keep `hardware.bluetooth.enable = true` and use DMS's Bluetooth controls.
- Remove `services.blueman.enable = true` from `hosts/thinkpad/laptop.nix`
  once DMS integration is ready.
- Purpose: preserve Bluetooth device support while consolidating its desktop
  controls in DMS.
- Bluetooth power-on behavior has not been discussed; no change is planned.

### Networking and VPNs

- Keep NetworkManager for Wi-Fi/Ethernet and use DMS's network controls.
- Preserve occasional Proton VPN use; review its application configuration in
  the later home phase.
- Keep the standalone OpenVPN client for rare university VPN connections.
- Do not add a NetworkManager OpenVPN plugin or migrate the university VPN
  profile into NetworkManager.
- Preserve `networking.networkmanager.enable = true` in
  `hosts/thinkpad/default.nix`; no extra host VPN settings are planned.
- Keep the existing Proton VPN and OpenVPN packages in `home/thinkpad.nix`
  for the home review. No custom DNS or static addressing is proposed.
- Purpose: preserve the user's network and VPN workflows while using DMS for
  everyday network controls.

### Laptop power profiles

- Keep TLP and enable its optional profile daemon (`tlp-pd`) so DMS can offer
  power-saving, balanced, and performance profile selection.
- Pinned-source inspection confirms `services.tlp.pd.enable` is available.
  Enable it and explicitly disable `services.power-profiles-daemon.enable`,
  which DMS would otherwise enable by default.
- Affected file: `hosts/thinkpad/laptop.nix`.
- Purpose: retain TLP's laptop power management while adding DMS controls.
- Do not run TLP and power-profiles-daemon together.
- Custom profile tuning has not been agreed. Charge thresholds, suspend, and
  supporting power-service decisions are recorded below.

### Battery charge limits

- Set the stop threshold to 90% and the start threshold to 85%.
- The user rarely charges the device and finds its unplugged runtime ample.
- Hardware verified read-only in this session: DMI identifies a ThinkPad T14
  Gen 1; BAT0 exposes both `charge_control_start_threshold` and
  `charge_control_end_threshold`. Observed values were 0 and 100 respectively.
  This confirms that the kernel exposes charge-threshold support on this device;
  no values were changed.
- Planned settings in `services.tlp.settings` in `hosts/thinkpad/laptop.nix`:
  `START_CHARGE_THRESH_BAT0 = 85;` and `STOP_CHARGE_THRESH_BAT0 = 90;`.
- Purpose: reduce time at full charge while retaining most unplugged capacity.
- After authorized implementation and activation, verify the applied values
  through `tlp-stat -b` or the kernel's charge-threshold files.

### Closing the lid

- Lock and suspend when closing the lid, on battery or AC power.
- Keep the laptop running with the lid closed when an external display is
  connected.
- Affected host file: `hosts/thinkpad/laptop.nix`, through logind lid settings.
- Purpose: provide normal portable sleep behavior while allowing use with an
  external display and closed lid.
- Integrate reliable DMS locking before suspend during the later home review;
  verify session inhibitors and actual dock/external-display behavior before
  treating the implementation as complete.
- Idle timeouts are recorded under the home idle-behavior decision. The
  sleep-mode decision is recorded below.

### Sleep mode

- Use ordinary suspend only; do not add hibernation or suspend-then-hibernate.
- Purpose: retain the simpler sleep setup selected by the user.
- No disk-backed swap or resume configuration is to be added for hibernation.
  The later memory-pressure decision also keeps the system without swap.

### Supporting power services

- Keep thermald for Intel thermal management and UPower for battery/power
  information.
- Remove `services.acpid.enable = true` from `hosts/thinkpad/laptop.nix` once
  the effective configuration confirms that no inherited handlers or service
  dependencies require it.
- No custom acpid handlers are declared in the repository's host/shared
  modules; the inspected upstream NixOS module's default event commands are
  empty. The agreed lid/suspend policy uses logind and DMS session integration.
- Purpose: retain useful hardware services and remove the unused event daemon.
- The `acpi` command-line package is separate and is not included in this
  daemon-removal decision.

### Firmware updates

- Preserve the existing driver-firmware and Intel microcode support.
- Enable `services.fwupd.enable = true` in `hosts/thinkpad/laptop.nix` for
  checking and manually installing supported vendor device/BIOS updates.
- The user accepted the explained UDisks2 dependency of the NixOS fwupd module.
  This does not enable GVfs or expand Nautilus's agreed scope.
- Purpose: make supported firmware updates available through LVFS on NixOS.
- Enabling the service is not authorization to flash firmware during this review.
- The pinned nixos-hardware profile and its transitive imports were inspected;
  they do not enable fwupd. See the findings below for other inherited settings.

### Hardware profile

- Keep the existing `lenovo-thinkpad-t14-intel-gen1` profile unchanged in
  `flake.nix`.
- Purpose: retain model-specific compatibility settings and hardware defaults.
- Do not remove inherited fixes or generated hardware settings as incidental
  cleanup. Explain any proposed removal of redundant local declarations
  separately. Detailed findings follow.

### Keyboard and regional settings

- Keep German console and system graphical keyboard layouts in
  `hosts/thinkpad/default.nix`.
- Keep `Europe/Berlin` as the time zone.
- Use English interface/messages with German regional formatting on ThinkPad.
- Preserve the shared `en_US.UTF-8` default in `modules/common.nix`; add
  ThinkPad-only `i18n.extraLocaleSettings` in `hosts/thinkpad/default.nix`.
- Planned German categories (`de_DE.UTF-8`): time/date, numeric, monetary,
  measurement, and paper size. Keep message language English and avoid LC_ALL,
  which would override the category-specific choices. LC_TIME also controls
  localized weekday/month names in applications that use it.
- Purpose: match local formatting conventions while retaining English text.
- WSL's regional defaults are unchanged by this decision. Niri input overrides
  and DMS clock appearance remain for the home review.

### Steam and gaming

- The user occasionally plays games locally and wants to keep most of the
  existing configuration for now.
- Keep Steam, Protontricks, Proton-GE, and 32-bit graphics support in
  `hosts/thinkpad/default.nix`.
- Purpose: preserve the existing local gaming setup.
- Remove the explicit `true` declarations for
  `programs.steam.remotePlay.openFirewall` and
  `programs.steam.dedicatedServer.openFirewall`, letting both return to their
  default `false` values after verification.
- Purpose of the firewall change: stop opening ports for unused Remote Play
  and Source Dedicated Server hosting while retaining the local gaming setup.

### Development-device access

- Keep `platformio-core.udev` in `services.udev.packages` in
  `hosts/thinkpad/laptop.nix`.
- Keep the user's `dialout` group membership in `modules/common.nix`.
- Purpose: retain access to development boards and serial devices.
- These are host-level permissions and device rules. Development applications
  and toolchains remain for the later home/project review.

### Boot and recovery

- Keep systemd-boot and permission to update EFI boot entries.
- Keep weekly Nix garbage collection with `--delete-older-than 30d`.
- Add `boot.loader.systemd-boot.configurationLimit = 5` in
  `hosts/thinkpad/default.nix`.
- Purpose: bound boot-menu entries and boot-partition usage across rebuilds.
  This is a maximum number of entries, not a guarantee that five old
  generations survive garbage collection.
- Read-only inspection found an approximately 1 GiB `/boot` partition with
  122 MiB used and two boot-entry files at the time of review.
- No cleanup, generation-deletion, or partition actions are authorized as part
  of recording this plan.

### Sudo authentication

- Keep passwordless sudo: preserve
  `security.sudo.wheelNeedsPassword = false` in `modules/common.nix`.
- Purpose: retain the user's preferred administrative workflow.
- No ThinkPad-specific override is to be added; the shared setting stays as is.

### Nix daemon trust

- Keep `nix.settings.trusted-users = [ "root" "kaleb" "@wheel" ]` in
  `modules/common.nix`.
- Purpose: preserve the user's existing Nix administrative capabilities and
  convenience, including adding binary caches from the client.
- The user was informed that these privileges are effectively root-equivalent.
- No ThinkPad-specific override or shared trust-policy change is planned.

### Prebuilt-program compatibility

- Keep `programs.nix-ld` enabled with its existing `stdenv.cc.cc` library
  declaration in `modules/common.nix`.
- Purpose: retain compatibility support for dynamically linked Linux
  executables obtained outside nixpkgs, including development-tool downloads.
- Add additional libraries only for identified needs; no speculative library
  expansion is planned.
- Keep the shared configuration unchanged for ThinkPad and WSL.

### Printing

- No printing service is needed at present.
- Leave `# services.printing.enable = true;` commented out in
  `hosts/thinkpad/default.nix`; preserve it as a reminder for future use.
- No printing configuration change is planned.

### Incoming SSH access

- Leave `# services.openssh.enable = true;` commented out in
  `hosts/thinkpad/default.nix`.
- No incoming SSH service or associated firewall opening is planned.
- Outgoing SSH client use is unaffected by this decision.

### Memory pressure and swap

- Keep the current setup without swap; do not enable zram or add disk swap.
- Read-only inspection found about 16 GB of RAM and no active swap.
- The user reports no applications unexpectedly closing or unresponsiveness
  under heavy use and does not currently need additional memory headroom.
- Preserve `swapDevices = [ ];` in the generated hardware configuration.
- The earlier zram recommendation was declined; suspend-only remains agreed.

### Firefox

- The user does not generally use Firefox.
- Plan to remove `programs.firefox.enable = true` from
  `hosts/thinkpad/default.nix` because the system-installed browser is unused.
- Actual configuration edits still await implementation approval.
- Brave and browser preferences remain for the later home review.

### Basic command-line tools

- Keep `vim`, `wget`, and `curl` in `environment.systemPackages` in
  `hosts/thinkpad/default.nix`.
- Purpose: preserve system-wide editing, download, and troubleshooting tools
  independently of the Home Manager setup.
- Customized Neovim and editor preferences remain for the later home review.

### Laptop command-line utilities

- Keep `brightnessctl`, `acpi`, and `lm_sensors` in
  `environment.systemPackages` in `hosts/thinkpad/laptop.nix`.
- Purpose: retain manual brightness control and hardware diagnostics.
- Keeping the `acpi` command does not reverse the agreed removal of the separate
  `acpid` service. DMS brightness integration and shortcuts remain to be reviewed.

### Desktop package placement and dependencies

- The user accepts moving the retained desktop utilities from
  `hosts/thinkpad/desktop.nix` to ThinkPad Home Manager during the home review.
- Preserve Niri functionality and applications referenced by other components.
  Moving package ownership is not permission to remove the applications.
- Inspected the pinned nixpkgs Niri module, its Wayland session helper, and the
  Niri package definition at revision
  `0af3d1402dec3fc7e93635e511d1f7428c89cebf`, available locally at
  `/nix/store/cxgsryi7amlpskyqy5yfiwh8w03kvpyp-source`.
  None declares a dependency on `kitty`, `playerctl`, `pavucontrol`, or `pamixer`.
- `kitty`: current Niri terminal shortcuts explicitly launch `ghostty`, enabled
  in shared Home Manager. No active repository command or explicit checked MIME
  association selects Kitty. Do not silently change terminal preferences.
- `pavucontrol`: actively launched by Waybar's audio widget in
  `home-modules/desktop/waybar.nix`. Preserve availability until that widget is
  replaced or its action is deliberately changed during DMS integration.
- `pamixer`: referenced by the legacy Hyprland module, which is not imported by
  the current ThinkPad home configuration. Niri audio shortcuts use SwayOSD.
- `playerctl`: directly launched by the same inactive Hyprland module. Niri uses
  `swayosd-client --playerctl play-pause`; that option name alone does not prove a
  dependency on the standalone executable. The pinned SwayOSD package does not
  declare the standalone package as a dependency. Preserve playback behavior and
  verify the replacement during the home review before deciding on removal.
- No references to these four applications were found in the two existing user
  `mimeapps.list` files checked. This does not rule out every runtime fallback.
- On implementation, keep retained executables and desktop entries visible to
  the user session and verify affected launchers/keybindings after migration.
  No package migration, configuration evaluation, or runtime test was performed
  during this source inspection.

### Graphical authorization prompts

- Retain the system Polkit service already enabled by Niri's pinned Wayland
  session helper, with standard authorization rules.
- Use DMS's built-in authentication agent for graphical password prompts.
- Do not add a separate graphical agent or blanket password-bypass rules.
- Passwordless sudo stays as agreed; Polkit authorization is separate.
- Host support remains supplied through `programs.niri.enable` in
  `hosts/thinkpad/desktop.nix`. Agent startup and integration belong to the
  later DMS session/home review.

### DMS startup

- Enable DMS through the native NixOS module in `hosts/thinkpad/desktop.nix`
  and use its systemd user service (`programs.dms-shell.systemd.enable = true`).
- Retain the default graphical-session target and `restartIfChanged = true`.
- Purpose: start DMS automatically with the graphical session, stop it with the
  session, and use the packaged service's restart-on-failure behavior.
- Do not add a duplicate Niri startup command or Home Manager DMS service.
- Coordinate activation with replacing the current session components during
  the home review, especially Mako, which also provides the notification service.
- This is an agreed plan; no DMS installation or service activation has occurred.

### DMS system monitoring

- Keep `programs.dms-shell.enableSystemMonitoring = true`, the pinned module's
  default, in the planned DMS setup in `hosts/thinkpad/desktop.nix`.
- Purpose: provide `dgop` for resource usage and process information in DMS.
- Widget visibility and layout remain for the later home review.

### DMS audio visualizer

- Keep `programs.dms-shell.enableAudioWavelength = true`, the pinned module's
  default, in the planned DMS setup in `hosts/thinkpad/desktop.nix`.
- Purpose: make the `cava`-based audio visualizer available.
- Widget visibility and placement remain for the later home review; this does
  not require showing the visualizer at all times.

### DMS calendar events

- Set `programs.dms-shell.enableCalendarEvents = false` in
  `hosts/thinkpad/desktop.nix`.
- Purpose: skip the optional `khal` dependency and appointment integration,
  which the user does not currently expect to use.
- Keep the ordinary clock/calendar display available. Calendar accounts and
  synchronization are not planned; event integration can be revisited later.

### DMS direct clipboard paste

- Keep `programs.dms-shell.enableClipboardPaste = true`, the pinned module's
  default, in `hosts/thinkpad/desktop.nix`.
- Purpose: make direct pasting from clipboard history available through `wtype`.
- Clipboard collection, retention, and keybinding preferences remain for the
  later home review; this decision covers the host dependency only.

### Theme separation between hosts

- The user's preferred direction is to retain Stylix for WSL; do not remove the
  shared Stylix flake input as part of the ThinkPad migration.
- DMS is intended for the ThinkPad, not WSL. WSLg integrates individual Linux
  applications with Windows and does not provide a full Linux desktop session;
  do not characterize DMS as categorically impossible to run on WSL.
- On the ThinkPad, the user is open to keeping Stylix for settings outside
  DMS/matugen's control or replacing those settings with direct declarations.
  Avoiding conflicts is the requirement; complete ThinkPad Stylix removal is
  not an agreed goal.
- Assign each generated file/setting to one owner. Do not let Stylix/Home Manager
  generate a file or symlink that DMS/matugen also tries to replace or write.
- The earlier proposal to retire Stylix on the ThinkPad is superseded by this
  more flexible direction. Specific target ownership remains to be reviewed.
- Agreed: enable `programs.dms-shell.enableDynamicTheming = true` in
  `hosts/thinkpad/desktop.nix` to provide matugen for DMS.
- Preserve the useful appearance defaults currently supplied by Stylix on the
  ThinkPad. Retaining Stylix itself is optional: choose selective Stylix targets
  or direct Home Manager declarations according to which is simpler and avoids
  overlapping settings. Do not keep Stylix solely for its own sake.
- Current font/cursor baseline for the later home review: Bibata-Modern-Classic
  cursor at size 24; FiraCode Nerd Font for monospace; DejaVu Sans and DejaVu
  Serif; font sizes 12 for applications/terminals and 10 for desktop/popups.
  These are explicit repository choices, not all upstream Stylix defaults.
- Preserve that baseline during migration unless the user chooses changes in
  the home review. Review other appearance settings such as opacity separately.

### DankSearch

- Enable the native `programs.dsearch` module in `hosts/thinkpad/desktop.nix`,
  using nixpkgs and its systemd user service with default user-session startup.
- Purpose: provide indexed file search through the DMS launcher.
- The pinned nixpkgs provides dsearch 0.3.2 and the native module; no additional
  upstream flake input is needed.
- Configure indexed folders, exclusions, content indexing, and resource limits
  during the later ThinkPad home review. Agree these before activating indexing.
- The service runs as the user, not as a root system service.

### External-monitor brightness

- Retain `hardware.i2c.enable = true`, supplied by the native DMS module's
  default, to make DDC/CI brightness control available for compatible monitors.
- This belongs to the ThinkPad host integration in `hosts/thinkpad/desktop.nix`;
  no extra declaration is needed if the DMS default supplies it as expected.
- The pinned I2C module loads `i2c-dev` and supplies local-seat/group access rules.
  Do not add user group memberships unnecessarily.
- Actual support depends on the monitor and connection. No monitor-specific
  tests or brightness changes have been performed.
- Laptop-panel brightness controls are separate and remain available.

### WSL USB passthrough

- Keep `wsl.usbip.enable = true` in `hosts/wsl/default.nix`.
- Purpose: retain USB/IP integration for accessing attached USB devices from WSL,
  including development devices.
- No Windows-side setup, device attachment, or automatic-attachment changes
  are planned as part of this decision.

### WSL host baseline

- Keep the remaining `hosts/wsl/default.nix` configuration unchanged: NixOS-WSL
  import/enablement, default user `kaleb`, hostname `wsl`, disabled OpenSSH
  server, enabled dconf, and `system.stateVersion = "25.05"`.
- Keep DMS, DankGreeter, and laptop hardware services specific to the ThinkPad.
- Together with the USB decision above, no WSL host edits are planned.

### Home: bar, notifications, and on-screen indicators

- Replace Waybar, Mako, and SwayOSD with DMS's bar, notifications, and
  volume/brightness indicators.
- Start from DMS's standard appearance and retire the custom Waybar styling.
- Stop importing `../waybar.nix` from `home-modules/desktop/niri/default.nix`;
  remove Mako/SwayOSD enablement from `home-modules/desktop/niri/session.nix`.
- Route existing volume, microphone mute, brightness, and playback key actions
  in `home-modules/desktop/niri/config.kdl` through verified pinned-DMS commands.
  Preserve Niri's window-management bindings.
- Replace these components together; verify no duplicate notification service
  or stale startup references remain. Account for the old Waybar pavucontrol
  click action and brightness scrolling when reviewing DMS controls.
- Bar layout/widgets and notification preferences remain separate decisions.
- This is an agreed plan, not authorization to implement the configuration.

### Home: bar placement and visibility

- Put the DMS bar at the top and keep it visible during normal use, with no
  automatic hiding during ordinary window use.
- Use DMS's standard styling and spacing rather than reproducing Waybar CSS.
- Configure this in ThinkPad-specific DMS home settings. Widget selection and
  multi-monitor behavior remain separate decisions.

### Home: bar widget layout

- Left: launcher, Niri workspaces, and active-window title.
- Center: time and date.
- Right: system tray, notifications, battery percentage, and control center.
- Use the control center for network, Bluetooth, volume, and brightness controls,
  consolidating some formerly separate Waybar widgets.
- System-monitor and media/visualizer support remains available; this decision
  does not require displaying those additional widgets permanently.
- Apply through ThinkPad-specific DMS home settings, with widget names/schema
  verified against the pinned DMS version before implementation.

### Home: bar on multiple displays

- Show the agreed DMS bar on every active display, including external monitors.
- Purpose: keep the clock, status, and controls accessible on each screen and
  when using an external display with the laptop lid closed.
- Monitor arrangement, scaling, and workspace filtering are separate choices.

### Home: notification popups

- Show DMS notification popups at the top right.
- Disable notification sounds.
- Retain standard DMS timeout behavior initially.
- Configure this in ThinkPad-specific DMS home settings. History, lock-screen
  content, and any application-specific rules remain separate decisions.

### Home: notification history

- Keep DMS notification history available to revisit missed notifications.
- Start with standard retention limits; inspect and document the pinned
  version's storage and retention defaults before implementation.
- Configure through ThinkPad-specific DMS home settings.

### Home: lock-screen notifications

- Show a notification count only on the DMS lock screen.
- Hide application/sender names and message contents until the session is
  unlocked; normal unlocked notification behavior remains as agreed.
- Configure through ThinkPad-specific DMS home settings.

### Home: idle behavior

- Retain automatic locking after 15 minutes without input and display power-off
  after 20 minutes. Do not add an automatic suspend timeout for inactivity.
- Move idle handling to DMS, replacing the swayidle/swaylock setup in
  `home-modules/desktop/niri/session.nix` with ThinkPad-specific DMS settings.
- Preserve the separately agreed lid-close suspend behavior and locking before
  suspend. Verify pinned-DMS inhibitor handling and lock-before-sleep sequencing
  during implementation; no runtime behavior has been tested yet.

### Home: application launcher

- Replace Fuzzel with the DMS launcher.
- Bind the launcher to `Mod+Space`, as explicitly requested, replacing the
  existing `Mod+D` Fuzzel binding in `home-modules/desktop/niri/config.kdl`.
- No `Mod+Space` binding was found in the current Niri configuration.
- Point the DMS bar's launcher button to the same launcher.
- Remove Fuzzel enablement from `home-modules/desktop/niri/session.nix` after
  active references are migrated. Verify the pinned DMS launcher command.
- DankSearch index scope remains a separate decision.

### Home: Nautilus integration

- Keep `Mod+E` as the file-manager shortcut, changing the current `thunar`
  command to Nautilus in `home-modules/desktop/niri/config.kdl`.
- Install Nautilus through ThinkPad Home Manager and make it the default
  `inode/directory` handler; verify the pinned desktop-entry ID.
- Preserve the previously agreed minimal local-file scope, without adding
  storage services for this decision.

### Home: terminal applications

- Keep Ghostty as the only explicitly configured terminal on the ThinkPad;
  the user only uses Ghostty.
- Preserve `Mod+Return` and `Mod+T` for launching Ghostty.
- Remove the Foot import from `home/thinkpad.nix` and Kitty from
  `hosts/thinkpad/desktop.nix` during implementation. Do not migrate Kitty into
  Home Manager merely to retain an unused terminal.
- Ensure DMS's terminal selection and terminal-based application launchers use
  Ghostty; inspect generated defaults/fallbacks before removing the alternatives.
- Keep the shared Ghostty module. Review appearance settings and WSL terminal
  preferences separately as needed.

### Home: default browser

- Keep Brave as the ThinkPad's default browser for HTTP/HTTPS links and HTML
  files, preserving the currently observed `brave-browser.desktop` associations.
- Declare those defaults in ThinkPad Home Manager and align DMS's browser
  selection with Brave.
- Firefox's host removal remains agreed; WSL browser defaults are separate.

### Home: DankSearch content indexing

- Start with file-name/path search only; do not index text contents.
- Manage `~/.config/danksearch/config.toml` through ThinkPad Home Manager.
- Verify the pinned version's exact mechanism for disabling content extraction
  before implementation. Folder scope and other indexing settings are separate
  decisions.

### Home: DankSearch folder scope

- Index Documents, Downloads, Pictures, Music, and Videos, plus `~/Code`.
- The user explicitly identified `~/Code` as their additional folder. Resolve
  the standard user-directory paths during implementation.
- Keep these as explicit index roots in the ThinkPad Home Manager configuration.

### Home: DankSearch exclusions

- Skip hidden files and directories, including within `~/Code`; hidden project
  files such as `.gitignore` need not appear in launcher results.
- Retain standard exclusions for dependencies, caches, and build output,
  including node_modules, virtual environments, build, dist, and target.
- Verify the pinned version's defaults and exclusion semantics before
  implementation; avoid accidentally replacing the default list when adding
  any exclusions.

### Home: DankSearch remaining indexing behavior

- Automatically update the index when files change.
- Include nested folders without a depth limit within the agreed roots,
  respecting the agreed exclusions.
- Disable image EXIF metadata extraction for this names/paths-only setup.
- Keep default indexing worker/resource settings initially.
- Verify pinned support and file-size-limit semantics before implementation
  so names of large media files remain searchable as intended.

### Home: DMS clipboard history

- Enable history for copied text and images, with a maximum of 100 entries
  and automatic removal of entries older than seven days.
- Retain history locally across restarts.
- Use `Mod+V` to open the clipboard history picker, replacing its current
  toggle-window-floating action. This supersedes the earlier `Mod+Ctrl+V`
  choice: the user rarely uses floating-window actions and explicitly prefers
  `Mod+V` for history. No replacement floating-toggle shortcut is requested.
- Leave `Mod+Shift+V` unchanged; no broader removal of floating-window support
  or shortcuts has been agreed.
- Manage preferences through ThinkPad Home Manager and the shortcut in
  `home-modules/desktop/niri/config.kdl`.
- Verify retention settings and picker IPC against pinned DMS 1.5.3 before
  implementation. Current upstream documents `clsettings.json`, `maxHistory`,
  `autoClearDays`, and `clearAtStartup`; avoid conflicting runtime writes.

### Home: screenshot tool

- Switch to DMS screenshot capture, superseding the recommendation to keep
  Niri's native capture actions.
- Preserve the existing key combinations and intended capture modes: Print
  for interactive region selection, Ctrl+Print for the focused screen, and
  Alt+Print for the focused window.
- Change the commands in `home-modules/desktop/niri/config.kdl` during the
  authorized implementation phase. Verify the exact commands and capture-mode
  support against pinned DMS 1.5.3 before implementation.
- Copy captures to the clipboard and save PNG files under
  `~/Pictures/Screenshots`, as agreed in the output-policy review.
- Manage output options through ThinkPad Home Manager/Niri's DMS capture
  commands; no capture commands have been changed or executed during review.

### Home: wallpaper and color baseline

- Start the ThinkPad with the existing `wallpapers/Sunset.png` wallpaper and
  dark mode.
- Derive supported colors from the wallpaper through DMS/matugen rather than
  keeping the fixed Tokyo Night Dark palette on the ThinkPad.
- Allow manual wallpaper changes through DMS; no automatic rotation initially.
- Implement through the ThinkPad Home Manager theme/DMS integration. Replace
  Niri's swaybg startup when DMS takes ownership of the wallpaper.
- Preserve WSL's separate Stylix theme. The previously agreed font/cursor
  baseline remains in effect; color migration does not authorize changing it.

### Home: Ghostty appearance

- Keep FiraCode Nerd Font at size 12, 10-pixel padding on both axes, a block
  cursor, and 90% background opacity on the ThinkPad.
- Integrate DMS/matugen colors while preserving those non-color settings.
- Keep the shared Ghostty module; scope ThinkPad-specific theme integration
  through its Home Manager configuration and preserve WSL's Stylix behavior.
- Verify effective settings and the generated theme-file integration before
  implementation so Home Manager and DMS do not write the same file.

### Home: DMS settings ownership

- Keep packages, services, Niri shortcuts, and font/cursor defaults declarative.
- Supply the agreed DMS preferences as repo-defined initial settings, allowing
  later GUI changes to persist across restarts and rebuilds.
- Later GUI adjustments remain local state until explicitly copied back into
  the repo; rebuilding must not silently reset those adjustments.
- Verify the pinned version's mechanisms and distinguish general settings,
  clipboard settings, and runtime session state during implementation. Define
  first-use initialization and handling of any existing files before activation;
  do not overwrite existing user settings blindly.
- Continue using nixpkgs, without adding the upstream DMS flake merely for its
  Home Manager options. Avoid read-only symlinks for files DMS needs to update.

### Home: standalone audio/media utilities

- Keep pavucontrol as an optional graphical audio troubleshooting tool, moving
  it from `hosts/thinkpad/desktop.nix` to ThinkPad Home Manager.
- Use DMS for everyday audio controls.
- Remove the explicit pamixer and playerctl package entries after verifying
  replacement DMS commands and their runtime dependencies. Preserve functioning
  volume, microphone-mute, and playback shortcuts.
- The user's approval covers this package plan; no separate manual/script use
  was reported. The inactive Hyprland module is not part of the DMS migration.

### Home: ThinkPad personal applications

- Keep Obsidian and Legcord; the user still uses both.
- Remove the `godot` entry from `home/thinkpad.nix` during implementation because
  the user no longer uses it. This is package removal only, not deletion of
  projects or application data.
- Brave and standalone Proton VPN/OpenVPN remain as previously agreed.

### Home: personal application theme scope

- Preserve Obsidian, Legcord, and Brave's existing in-app appearance choices.
- Keep DMS/matugen integration focused on the desktop, Ghostty, and supported
  native application surfaces. Do not add app-specific CSS, plugins, or templates
  solely to make these three applications match wallpaper colors.
- No personal app appearance settings have been inspected or changed.

### Home: Neovim theme independent of DMS

- Keep the existing Tokyo Night Dark base16 editor palette and configured
  transparent main, number-line, and sign-column backgrounds.
- Keep Neovim's theme separate from DMS: no DMS-generated colorscheme or
  wallpaper-driven syntax colors. Preserve the existing editor/statusline
  theme integration when restructuring Stylix ownership.
- DMS must not overwrite Nixvim-managed theme/configuration files. Disable or
  avoid its Neovim theme output where needed to prevent conflicts.
- Transparency still exposes Ghostty's background; this decision fixes the
  editor palette rather than changing the previously configured transparency.
- Preserve WSL's editor theme too. Implement through the Home Manager theme
  separation and Nixvim integration, using selective Stylix or direct settings
  as appropriate.

### Home: shell directory navigation

- Use zoxide alone for directory jumping on both ThinkPad and WSL.
- Preserve the enhanced `cd` behavior configured by `--cmd cd` in
  `home-modules/shell/zoxide.nix`.
- Remove the Oh My Zsh `z` plugin from `home-modules/shell/zsh.nix`; its
  separate `z` command will no longer be provided.
- No directory-history deletion or migration is planned.

### Home: fzf shell integration

- Keep fzf and its Home Manager Zsh integration on both ThinkPad and WSL.
- Remove the additional Oh My Zsh `fzf` plugin entry from
  `home-modules/shell/zsh.nix`.
- Preserve history/file/directory widgets and completion behavior, carrying
  over the plugin's file-search defaults into `home-modules/shell/fzf.nix`
  where needed.
- The inspected pinned Home Manager module loads `fzf --zsh`; current upstream
  Oh My Zsh also initializes fzf and conditionally sets FZF_DEFAULT_COMMAND to
  `fd --type f --hidden --exclude .git` when fd is present. Verify that behavior
  in pinned Oh My Zsh revision 97e11051e2f8053b1d694788d1cb4b0dbb1e2365 before
  implementation; fetching that exact plugin source via web was unsuccessful.
- Shell fzf's search scope is separate from the agreed DankSearch exclusions.

### Home: Starship prompt

- Keep the shared Starship prompt layout, symbols, and behavior on ThinkPad
  and WSL in `home-modules/shell/starship.nix`.
- Preserve directory, Git branch/status, Nix-shell and relevant language
  information, command duration from two seconds, and the next-line
  success/error prompt.
- Account for any Stylix-generated prompt styles when separating themes;
  terminal ANSI colors may follow Ghostty's palette without changing the
  prompt's agreed layout and behavior.

### Home: project environment integration

- Keep direnv, nix-direnv, and their Zsh integration unchanged in the shared
  `home-modules/shell/direnv.nix` on both ThinkPad and WSL.
- Preserve normal per-project `.envrc` authorization and environment
  loading/unloading; do not add automatic directory-wide trust.
- No project environment has been authorized or loaded during review.

### Home: tmux workflow

- Keep tmux and its existing workflow on both ThinkPad and WSL in
  `home-modules/tmux.nix`: Ctrl+A prefix, mouse support and better-mouse-mode,
  50,000-line history, window numbering from one, and current-directory
  splits/new windows using prefix | / - / c.
- No changes to the existing socket location, terminal capabilities, extended
  keys, escape delay, clock format, or newSession setting are currently planned.
  Verify terminal compatibility during implementation and explain any required
  correction before expanding the agreed changes.
- Preserve Stylix's tmux styling according to the agreed selective theme
  ownership below.

### Home: selective Stylix ownership on the ThinkPad

- Retain Stylix on the ThinkPad for explicit tmux and Nixvim targets using
  the existing fixed Tokyo Night Dark palette. Wallpaper changes must not
  change these applications' theme palettes.
- Set `stylix.autoEnable = false` for the ThinkPad and explicitly enable the
  chosen targets. Disable the existing explicit GTK/GNOME targets and leave
  Ghostty's colors to DMS/matugen.
- Preserve fonts and cursor through non-conflicting Stylix targets or direct
  Home Manager declarations, assigning each setting/file a single owner.
- Preserve WSL's existing Stylix policy. Separate host policies through
  `home-modules/desktop/stylix.nix` and per-host Home Manager imports/options.
- This resolves the earlier open choice between selective Stylix retention and
  complete removal on the ThinkPad in favor of selective retention.
- Current upstream tmux target sources a generated tinted-tmux base16 theme
  via programs.tmux.extraConfig. Verify the exact pinned target before
  implementation; raw pinned source retrieval returned a cache miss.

### Home: Git defaults

- Keep the configured Git identity, `main` as the initial branch, and
  `pull.rebase = true` on both ThinkPad and WSL.
- Change `core.editor` from `vim` to `nvim` in `home-modules/git.nix` so Git
  editing uses the configured Neovim setup.

### Home: outgoing SSH

- Keep `home-modules/ssh.nix` as configured on both ThinkPad and WSL: the
  dedicated Home Manager ssh-agent, AddKeysToAgent=yes, the configured
  `~/.ssh/id_ed25519` identity path, GitHub's git user, and current keepalives.
- Keep SSH agent ownership separate from GNOME Keyring login unlocking.
  A passphrase-protected key may require unlocking on first use; the agent
  then keeps it available while loaded.
- Verify effective SSH_AUTH_SOCK and absence of competing agent startup during
  implementation. The pinned GNOME Keyring module registers gcr D-Bus support
  without explicitly configuring an SSH agent; effective session behavior still
  needs checking.
- No private keys have been read or changed and no SSH connections have been
  made during review.

### Home: shell aliases

- Remove the `emacs`, `ect`, and `ecg` aliases from the shared
  `home-modules/shell/zsh.nix` during implementation, affecting both hosts.
- Keep `la` and `rebuild`.
- The later cleanup decision also authorizes planning deletion of the inactive
  Doom Emacs module and its repository references. Personal Emacs data is outside
  this repository cleanup.

### Home: ts project-session helper

- Keep the shared `ts` helper in `home-modules/shell/scripts.nix` on both hosts;
  the user still uses it.
- Preserve its project-directory session naming, Neovim plus extra shell
  windows, reconnect behavior, and custom name/window-count options.
- No helper execution or tmux session changes have been performed during review.

### Home: everyday command-line utilities

- Keep htop, fastfetch, yazi, ripgrep, fd, and lazygit in `home/common.nix`
  on both ThinkPad and WSL.
- Keep Yazi available for terminal file browsing alongside Nautilus as the
  ThinkPad's graphical directory default.

### Home: development utilities

- Keep devenv and python3 in `home/common.nix` on both ThinkPad and WSL.
- Keep usbutils through the shared `home-modules/esp32.nix`; this module
  currently installs only usbutils, not an ESP32 toolchain.
- Keep project-specific SDKs and dependencies in project environments as
  needed; no global toolchain expansion is planned.

### Home: coding-agent packages

- Keep Pi on both ThinkPad and WSL, using the existing llm-agents flake input.
- Remove `opencode2` from `home/common.nix` during implementation; the user
  uses Pi but no longer uses OpenCode.
- Keep the llm-agents input because Pi still uses it. This package change does
  not authorize deletion of OpenCode's local data or credentials.

### Home: ThinkPad speech utilities for Pi

- Keep whisper-cpp and piper-tts in `home-modules/pi.nix`, imported only by
  the ThinkPad home configuration.
- The user uses both through a Pi plugin that lives outside this repository;
  that external integration explains their placement in the Pi module.
- Preserve the module's role and package scope; do not remove the tools based
  on absence of plugin settings in this repository.

### Home: preserve Nixvim entirely

- Keep the complete shared Nixvim configuration on both hosts, as explicitly
  requested: options, keybindings, plugins, language servers, completion,
  navigation, formatting, Git integration, and debugging.
- Preserve its fixed theme and transparency independently of DMS as agreed.
- No edits to `home-modules/nixvim/` are planned. Implement theme ownership
  through surrounding Stylix/per-host Home Manager settings instead.
- No editor functionality has been changed or runtime-validated during review.

### Home: XWayland compatibility

- Keep xwayland-satellite available in ThinkPad Home Manager.
- Use Niri's automatic, on-demand integration instead of the manual
  `spawn-at-startup "xwayland-satellite"` line in
  `home-modules/desktop/niri/config.kdl`.
- Pinned nixpkgs provides Niri 26.04 and xwayland-satellite 0.8.2, meeting
  upstream's documented requirements (Niri >=25.08, satellite >=0.7).
- Verify session PATH, DISPLAY, and X11 application launching during
  implementation, preserving compatibility for Steam and other X11 apps.

### Home: remove unused configuration and references

- Delete retired configuration rather than retaining it as unimported reference
  material, as explicitly requested by the user.
- Planned deletions after migrating the agreed retained behavior:
  - `home-modules/desktop/waybar.nix`.
  - `home-modules/desktop/niri/session.nix` (Fuzzel, Swaylock, Mako, SwayOSD,
    and Swayidle replaced by DMS).
  - `home-modules/desktop/hyprland.nix` (inactive compositor configuration).
  - `home-modules/doom-emacs/`, including its module and three Doom files.
  - `home-modules/terminal/foot.nix` (Ghostty-only terminal decision).
- Clean imports in `home/thinkpad.nix` and the Niri module, commented Doom input
  and output references in `flake.nix`, and stale package/startup/keybinding
  references in the active ThinkPad configuration.
- Remove ReGreet's configuration block during the DankGreeter migration and
  the already agreed unused package entries (Godot, OpenCode, Kitty, pamixer,
  playerctl, Blueman, and replaced session components as applicable).
- Preserve the explicitly retained commented printing/SSH reminders, Nixvim
  in full, shared development templates, Pi speech module, and Sunset wallpaper.
- This choice specifies the cleanup in the eventual implementation proposal;
  only the decision log is changed during this review.

## Hardware-profile findings

Inspected the exact nixos-hardware revision pinned in `flake.lock`:
`dc3f0cfde2050172abf6c3cdb684f735c15a57c5`. Its source is available locally at
`/nix/store/ni6l286828cfnvhjsqnl2k7cnb5ix9pj-source`.

`flake.nix` imports `lenovo-thinkpad-t14-intel-gen1` only for the ThinkPad.
The profile imports T14, ThinkPad, laptop, SSD, Intel CPU, and Intel GPU modules.
Together these supply:

- Intel CPU microcode updates as a default when redistributable firmware is
  enabled; this repeats the default in `hardware-configuration.nix`.
- Intel graphics setup, including early i915 loading, video/compute driver
  packages, a legacy compute-runtime selection, and `i915.enable_guc=2`.
- Backlight and touchpad kernel parameters: `acpi_backlight=native` and
  `psmouse.synaptics_intertouch=0`.
- TrackPoint and wheel-emulation defaults.
- TLP enabled by default when power-profiles-daemon is disabled; the local
  `services.tlp.enable = true` makes the chosen power manager explicit.
- Periodic SSD TRIM enabled by default through `services.fstrim`.
- A legacy kernel fallback for kernels older than 5.2, and conditional ath3k
  blacklisting when redistributable firmware is disabled.

This import chain does not enable fwupd, thermald, UPower, or acpid. It does not
set battery charge thresholds. The firmware-update service and charge limits
we agreed therefore still need host configuration.

Decision: retain the hardware profile unchanged. It complements fwupd with
hardware configuration and compatibility settings.

## Agreed migration direction

- Adopt DankMaterialShell (DMS) from nixpkgs with the session integration and
  optional features agreed above.
- Use DankSearch with the agreed indexing scope and matugen with the agreed
  wallpaper/theme policy on the ThinkPad.
- Retain Stylix on WSL and selectively on the ThinkPad for tmux and Neovim.
  Preserve font/cursor defaults without overlapping theme writers.

## Remaining feature review

The feature preference review is complete. The user chose deletion of unused
configuration and references; the exact cleanup list is recorded above.
Next: verify the pinned runtime/module details and produce the final file-by-file
implementation proposal. Configuration implementation still requires explicit
approval of that proposal.

The WSL host review is complete with no host edits planned. The main ThinkPad
host feature choices are recorded above. Implementation still needs effective
configuration validation and coordination with the home/session migration.
Do not activate DMS alongside the services it is intended to replace.

The theme direction is agreed: DMS/matugen for supported ThinkPad desktop and
Ghostty colors and wallpaper, with selective Stylix retained for the fixed tmux
and Neovim themes. Use `stylix.autoEnable = false` on the ThinkPad and explicitly
enable the chosen non-overlapping targets. Disable the current explicit
GTK/GNOME target settings; autoEnable alone does not disable them. Preserve
font/cursor defaults through non-conflicting targets or direct Home Manager
settings. Verify exact option/file ownership during implementation.

Scope theme policy per host through `home/thinkpad.nix` and `home/wsl.nix`,
refactoring unconditional theme settings out of `home/common.nix` as necessary.
Preserve WSL's chosen Stylix setup and the flake input. `flake.nix` imports the
NixOS Stylix module for both hosts; the repository explicitly enables Stylix in
the shared Home Manager theme module, not in a host-level Stylix declaration.
Check NixOS-to-Home-Manager inheritance and effective targets before edits.

Current theme dependencies: `home/common.nix` imports the shared Stylix settings
and Home Manager module for both hosts; `flake.nix` imports its NixOS module for
both hosts. Niri and Waybar read Stylix colors, Niri reads its wallpaper, and
`home/thinkpad.nix` configures Stylix GTK/GNOME targets. The shared theme module
also selects fonts, cursor, opacity, and Neovim transparency. These need explicit
review/replacement; enabling matugen alone does not migrate them. Color choices,
theme templates, fonts, cursors, and application coverage remain for the home
review. Preserve Niri's agreed window-management behavior during this work.

Desktop package placement and the reviewed utility retention choices are
agreed, with dependency preservation required. Keep pavucontrol in ThinkPad
Home Manager; remove Kitty, pamixer, and playerctl as specified above.

Pinned-source implementation findings to account for in the later review:

- The pinned nixpkgs provides DMS 1.5.3; current upstream documentation describes
  1.6. Verify features against the pinned version before using current examples.
- The native DMS module enables power-profiles-daemon with `mkDefault true`.
  Implementing the agreed TLP + tlp-pd setup therefore needs an explicit
  `services.power-profiles-daemon.enable = false` override.
- Niri's Wayland session helper also declares `security.pam.services.swaylock`.
  Removing the local duplicate will not remove the generated PAM service.
  Do not introduce an override merely to remove this harmless inherited entry.
- The pinned DankGreeter module uses the greeter bundled with DMS 1.5.3, not the
  standalone 1.6 package described by current documentation. It supports Niri
  and `configHome = "/home/kaleb"`. Remove the old explicit greetd
  `default_session.user = "greeter"` when replacing ReGreet: the new module
  declares its own `dms-greeter` account and session command.
- Its theme-copy mechanism runs in `greetd.preStart`: settings, session state,
  colors, and referenced wallpapers are copied into `/var/lib/dms-greeter`.
  This alone does not establish live synchronization after every DMS theme
  change. Review runtime synchronization during the home phase without
  restarting greetd in an active graphical session or broadening home-directory
  permissions unnecessarily. No lockfile update is currently needed just to
  obtain the inspected host modules; runtime feature compatibility remains to
  be validated.

The principal host/home feature choices are recorded. The final proposal below
incorporates the pinned-source checks; implementation and runtime validation
remain subject to the approval stages described there.

Checks to carry into implementation:

- Validate generated settings/commands, theme files and greeter synchronization
  against the inspected pinned sources.
- Verify font/cursor and Niri focus-ring file ownership without theme conflicts.
- Verify WSL keeps its existing theme and only the agreed shared-home changes.
- Obtain explicit approval of the final file-by-file implementation proposal,
  followed by appropriate validation if implementation is authorized.

Current greeter documentation describes live synchronization via shared files
and permissions, and explicitly says its `dms-greeter sync` helper is unavailable
on NixOS. Do not run that helper or assume the current standalone greeter's
instructions apply to pinned bundled DMS 1.5.3. Resolve the supported declarative
mechanism against the pinned source; the existing preStart-copy finding remains
relevant and does not alone establish live synchronization.

## Final implementation proposal — approved

The feature review is complete. The following is the proposed implementation
scope, including the user's decision to delete unused configuration and its
references. Approval of this proposal authorizes repository changes and their
validation; system activation remains a separate step.

### Files to change and why

| File | Proposed change and purpose |
| --- | --- |
| `hosts/thinkpad/default.nix` | Replace the complete ReGreet block with native nixpkgs DankGreeter using Niri and password login. Remove the old explicit greeter user. Keep keyboard, boot, GC, networking and state version; add German regional locale overrides and five boot generations. Remove Firefox and the two Steam server/remote-play firewall flags, preserving local gaming. Retain the commented printing and SSH settings. |
| `hosts/thinkpad/desktop.nix` | Enable the native DMS and DankSearch modules and DMS lock authentication. Keep Niri, portals, PipeWire ALSA/Pulse/WirePlumber and rtkit; remove JACK and the duplicate local Swaylock PAM declaration. Remove retired desktop package entries, moving pavucontrol to ThinkPad Home Manager. Select the agreed DMS integrations, disable calendar-event integration and explicitly disable power-profiles-daemon. |
| `hosts/thinkpad/laptop.nix` | Keep Bluetooth, thermald, UPower, firmware, device tools and PlatformIO rules. Replace Blueman controls with DMS, enable TLP's power-profile interface, set BAT0 start/stop thresholds to 85/90, add manual fwupd availability, remove unused acpid, and set the agreed lid/suspend behavior. |
| `hosts/thinkpad/dms-greeter-sync.nix` (new) | Provide a narrowly scoped service that refreshes the greeter's copies of DMS settings, colors and referenced wallpapers when those files change, as well as before greeter startup. Use the module's `/var/lib/dms-greeter` location, rewrite copied wallpaper paths and set greeter ownership. Do not restart greetd to update a theme. |
| `home/thinkpad.nix` | Remove the Foot import and Godot package. Add Nautilus and pavucontrol, declare Brave and Nautilus MIME defaults, and import the new DMS home module. Apply ThinkPad-only Stylix target selection. Keep Obsidian, Legcord, ProtonVPN, OpenVPN, fonts and the Pi speech module. |
| `home-modules/desktop/dms.nix` (new) | Define the agreed initial DMS bar, notification, lock, idle, wallpaper, font, cursor and clipboard settings; seed writable settings/session/clipboard files only when absent. GUI edits remain persistent. Declare DankSearch's restricted roots and filename-only indexing configuration. Configure desktop theme ownership and required generated-file references. |
| `home-modules/desktop/niri/default.nix` | Remove Waybar/session imports and swaybg. Keep xwayland-satellite available for Niri's automatic integration. Replace Stylix color/wallpaper interpolation with a DMS color include and a valid initial fallback so first login works before matugen has generated colors. |
| `home-modules/desktop/niri/config.kdl` | Preserve input, outputs, layout, window management and retained bindings. Remove retired startup commands; use DMS launcher on Mod+Space, clipboard on Mod+V, lock, media/audio/brightness controls and screenshots. Set Mod+E to Nautilus. Remove the superseded launcher and floating-window-toggle bindings. |
| `home-modules/desktop/stylix.nix` | Keep the shared fixed palette, fonts, cursor, transparency and WSL behavior. Support ThinkPad selection of tmux, Nixvim and fontconfig without enabling competing desktop/Ghostty color targets. |
| `home-modules/terminal/ghostty.nix` or ThinkPad override | Preserve padding, block cursor, font size and opacity. On ThinkPad only, select the DMS-generated `dankcolors` theme; keep WSL's Stylix theme. |
| `home/common.nix` | Remove OpenCode; keep Pi, its flake input, all agreed CLI/development tools and the complete Nixvim import. |
| `home-modules/shell/zsh.nix` | Remove unused Emacs aliases and redundant Oh My Zsh z/fzf plugins; retain git, zoxide integration and the agreed aliases. |
| `home-modules/shell/fzf.nix` | Preserve the existing fd file-search defaults explicitly if removing the Oh My Zsh plugin otherwise drops them; keep Home Manager as the single Zsh integration owner. |
| `home-modules/git.nix` | Set Git's editor to nvim, preserving identity, main and rebase preferences. |
| `flake.nix` | Remove the commented Doom Emacs input/output references. Keep existing inputs and host definitions, including Stylix, llm-agents and the ThinkPad hardware profile. |

Delete the five paths listed in **Home: remove unused configuration and
references** above, including all four files under `home-modules/doom-emacs/`.
Remove their active and commented imports, package entries and startup/keybinding
references during the same migration. Retained documentation may mention them
historically; those mentions are not configuration references.

### Pinned-source compatibility findings

Read-only source inspection confirmed these details against DMS 1.5.3,
DankSearch 0.3.2 and the existing Stylix revision:

- DankSearch supports `index_all_files = true` with `text_extensions = []`.
  Its loader rebuilds the extension map without replacing that empty list,
  and its indexer then records file metadata without reading text bodies.
  Disable EXIF and xattr-tag indexing for the agreed filename/path search.
  `max_file_bytes` limits text reads, not inclusion of large media filenames.
  Use `merge_default_exclude_dirs = true` to retain built-in exclusions.
- DMS supports region, focused-output and Niri window screenshots, PNG,
  file plus clipboard output, and an explicit output directory.
- Clipboard settings support `maxHistory = 100`, `autoClearDays = 7`, and
  `clearAtStartup = false`. The pinned entry-size default is 5 MiB; retain it.
- Notification history is persisted and its pinned defaults are 50 entries
  and seven days. Retain those defaults, separate from clipboard history.
- Matugen has separate switches for Niri, Ghostty and Neovim templates. Enable
  the agreed desktop/Ghostty outputs and disable Neovim and unused-app outputs.
  Its generated paths include `niri/dms/colors.kdl` and
  `ghostty/themes/dankcolors` under the user's configuration directory.
- Stylix's pinned tmux target sources its generated tinted-tmux theme. Its
  Nixvim target supports the existing theme/transparency settings. Fontconfig
  can be selected independently; its cursor declaration remains active when
  Stylix is enabled even with autoEnable disabled. Keep cursor baseline
  ownership there, with DMS initially following the system cursor.
- The greeter module's built-in copy runs only at greetd service startup.
  The proposed synchronization service addresses later DMS changes. The pinned
  greeter reads settings/session/colors without watching them live: copied
  changes take effect for the next greeter instance. Do not promise instant
  updates to an already open login screen or run upstream's non-NixOS sync tool.

Pinned source references:

- [DMS 1.5.3 settings schema](https://github.com/AvengeMedia/DankMaterialShell/blob/v1.5.3/quickshell/Common/settings/SettingsSpec.js)
- [DMS 1.5.3 screenshots](https://github.com/AvengeMedia/DankMaterialShell/blob/v1.5.3/core/cmd/dms/commands_screenshot.go)
- [DMS 1.5.3 clipboard configuration](https://github.com/AvengeMedia/DankMaterialShell/blob/v1.5.3/core/internal/server/clipboard/types.go)
- [DankSearch 0.3.2 configuration](https://github.com/AvengeMedia/danksearch/blob/v0.3.2/internal/config/config.go)
- [DankSearch 0.3.2 indexer](https://github.com/AvengeMedia/danksearch/blob/v0.3.2/internal/indexer/indexer.go)
- [Pinned Stylix tmux target](https://github.com/nix-community/stylix/blob/5e3809851f486e7fc7e84b40f174c74b60ecc784/modules/tmux/hm.nix)

### Validation and preserved scope

After implementation approval, check formatting/syntax, evaluate both host
configurations, validate generated Niri configuration and search for stale
configuration references. Build the changed ThinkPad configuration and check
the WSL configuration for shared-home regressions as feasible. Review the diff
against this log and report any unavailable checks explicitly.

Do not edit `home-modules/nixvim/`, `home-modules/pi.nix`, the tmux workflow,
SSH setup, Starship, direnv, project-session helper, development templates,
generated hardware configuration, WSL host configuration or state versions.
Keep the lockfile unless a demonstrated incompatibility requires a separately
explained change. No personal application data is part of repository cleanup.

Login/keyring unlocking, lock-before-suspend, battery thresholds, clipboard and
screenshots, greeter synchronization, portal/file-manager behavior, audio,
network/Bluetooth controls and XWayland require runtime checks after activation.
Before requesting activation, provide the completed diff and build/evaluation
results. Repository implementation approval alone does not authorize activation.

## Implementation status

The user approved repository implementation and validation on 2026-10-01,
with incremental commits and progress reports. Branch: `thinkpad-dms-rework`.
System activation remains a separate approval.

Implementation sequence:

1. ThinkPad host defaults, DMS/greeter services and laptop power settings.
2. Greeter theme synchronization.
3. ThinkPad Home Manager DMS defaults, application selection and theme ownership.
4. Niri integration and retirement of the old desktop session modules.
5. Shared-home cleanup and deletion of remaining unused configuration/references.
6. Cross-host evaluation, build and final review.

Progress: preparation complete; steps 1–6 pending. No system activation performed.

## References

- [DMS compositor integration](https://danklinux.com/docs/dankmaterialshell/compositors)
- [DMS on NixOS](https://danklinux.com/docs/dankmaterialshell/nixos)
- [DankGreeter on NixOS](https://danklinux.com/docs/dankgreeter/nixos)
- [DankGreeter theme synchronization](https://danklinux.com/docs/dankgreeter/configuration#syncing-with-dms)
- [GNOME Keyring login integration](https://wiki.gnome.org/Projects/GnomeKeyring/Pam)
- [DMS lock-screen authentication](https://danklinux.com/docs/dankmaterialshell/lock-screen-authentication)
- [Nautilus network locations](https://help.gnome.org/gnome-help/nautilus-connect.html)
- [NixOS GVfs module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/desktops/gvfs.nix)
- [NixOS Niri module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/wayland/niri.nix)
- [Niri portal recommendations](https://niri-wm.github.io/niri/Important-Software.html#portals)
- [PipeWire overview](https://docs.pipewire.org/page_overview.html)
- [WirePlumber documentation](https://pipewire.pages.freedesktop.org/wireplumber/)
- [DMS features and integrations](https://danklinux.com/docs/dankmaterialshell/overview)
- [NixOS NetworkManager module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/networking/networkmanager.nix)
- [NetworkManager CLI reference](https://networkmanager.dev/docs/api/latest/nmcli.html)
- [TLP and desktop power profiles](https://linrunner.de/tlp/faq/ppd.html)
- [DMS power-profile controls](https://danklinux.com/docs/dankmaterialshell/keybinds-ipc)
- [TLP battery charge thresholds](https://linrunner.de/tlp/settings/battery.html)
- [Choosing battery charge thresholds](https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds)
- [ThinkPad battery care support](https://linrunner.de/tlp/settings/bc-vendors.html#lenovo-thinkpads)
- [Linux sleep states](https://docs.kernel.org/admin-guide/pm/sleep-states.html)
- [Intel thermald](https://github.com/intel/thermal_daemon)
- [UPower interface](https://upower.freedesktop.org/docs/UPower.html)
- [NixOS acpid module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/hardware/acpid.nix)
- [LVFS firmware updates](https://fwupd.org/)
- [NixOS fwupd module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/hardware/fwupd.nix)
- [Pinned T14 Gen 1 Intel hardware profile](https://github.com/NixOS/nixos-hardware/tree/dc3f0cfde2050172abf6c3cdb684f735c15a57c5/lenovo/thinkpad/t14/intel/gen1)
- [NixOS locale options](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/config/i18n.nix)
- [NixOS Steam module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/steam.nix)
- [PlatformIO device-access rules](https://docs.platformio.org/en/latest/core/installation/udev-rules.html)
- [NixOS systemd-boot options](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix)
- [NixOS sudo options](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/security/sudo.nix)
- [Nix trusted users](https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-trusted-users)
- [nix-ld documentation](https://github.com/nix-community/nix-ld)
- [CUPS printing system](https://openprinting.github.io/cups/)
- [Linux zram documentation](https://docs.kernel.org/admin-guide/blockdev/zram.html)
- [NixOS zram module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/config/zram.nix)
- [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- [lm-sensors](https://github.com/lm-sensors/lm-sensors)
- [ACPI client](https://sourceforge.net/projects/acpiclient/)
- [DMS built-in Polkit agent](https://danklinux.com/blog/v1-release#polkit-agent)
- [Pinned DMS 1.5.3 session service](https://github.com/AvengeMedia/DankMaterialShell/blob/v1.5.3/assets/systemd/dms.service)
- [DGOP system monitoring](https://danklinux.com/docs/dgop/)
- [DMS calendar integration](https://danklinux.com/docs/dankmaterialshell/calendar-integration)
- [DMS clipboard manager](https://danklinux.com/docs/dankmaterialshell/cli-clipboard)
- [DMS application theming](https://danklinux.com/docs/dankmaterialshell/application-themes)
- [Stylix configuration and target selection](https://nix-community.github.io/stylix/configuration.html)
- [WSLg desktop integration and limitations](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps)
- [DankSearch overview](https://danklinux.com/docs/danksearch/)
- [DankSearch native NixOS module](https://danklinux.com/docs/danksearch/nixos)
- [DMS brightness and DDC/CI support](https://danklinux.com/docs/dankmaterialshell/cli-brightness)
- [NixOS-WSL options](https://nix-community.github.io/NixOS-WSL/options.html)
- [Connecting USB devices to WSL](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)
- [DankSearch indexing configuration](https://danklinux.com/docs/danksearch/configuration)
- [Niri screenshot actions](https://github.com/niri-wm/niri/blob/main/docs/wiki/Configuration%3A-Key-Bindings.md)
- [DMS screenshot commands](https://danklinux.com/docs/dankmaterialshell/cli-screenshot)
- [direnv project environments](https://direnv.net/)
- [nix-direnv](https://github.com/nix-community/nix-direnv)
- [Niri's integrated XWayland startup](https://niri-wm.github.io/niri/Xwayland.html)
