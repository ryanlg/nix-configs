# AGENTS.md

## Purpose

This repo is a personal Nix flake organized around reusable modules plus per-host entrypoints under `hosts/`.
Most user-facing changes belong in Home Manager modules under `modules/home/*`.
Most macOS system changes belong in nix-darwin modules under `modules/os/darwin/*`.

Agents should optimize for small, local changes that preserve the existing module structure instead of introducing new abstraction layers.

## Repo map

- `flake.nix`: top-level inputs, overlays, formatter, and exported configs.
- `lib.nix`: composition helpers `mkSystem` and `mkHome`; this is where host/user wiring happens.
- `hosts/<hostname>/configuration.nix`: host-specific system settings.
- `hosts/<hostname>/home.nix`: host-specific Home Manager enablement.
- `modules/home/*`: Home Manager feature modules, grouped by domain.
- `modules/os/universal/*`: cross-platform system modules.
- `modules/os/darwin/*`: macOS-only system modules.
- `modules/os/nixos/*`: Linux-only system modules.
- `overlays/*`: package overlays; use only when a package-level fix is actually required.
- `bootstrap/`: bootstrap-only config, not the normal place for feature work.

## Architecture conventions

- Home Manager options live under `config.myHome.*`.
- System options live under `config.mySystem.*`.
- New features should usually be added as small modules with:
  - `options.<path>.enable = lib.mkEnableOption ...`
  - `config = lib.mkIf cfg.enable { ... };`
- When a module installs a package, follow the existing pattern of exposing a `package` option via `lib.mkPackageOption`.
- Use `default.nix` files as import aggregators for a directory when that pattern already exists nearby.
- Prefer extending an existing domain directory over creating a new top-level category.
- For split system features, keep the public entrypoint in `modules/os/universal/...` and put OS-specific implementations in `modules/os/darwin/...` and `modules/os/nixos/...`.
- Treat `modules/os/universal/...` as the generic coordination layer: shared options, shared imports, and feature structure belong there; platform-specific option names and service definitions belong in the OS-specific modules.
- Example pattern:
  - `modules/os/universal/sys/keymaps/default.nix`: generic feature entrypoint
  - `modules/os/darwin/sys/keymaps/kanata.nix`: nix-darwin implementation
  - `modules/os/nixos/sys/keymaps/kanata.nix`: NixOS implementation when needed
- Do not force a feature into one cross-platform file if NixOS and nix-darwin expose materially different options; prefer the split implementation scheme already used in this repo.

## Module templates

Use these as defaults unless a nearby module already establishes a better local pattern.

Home Manager module with `enable` only:

```nix
{
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.<category>.<name>;
in
{
  options.myHome.<category>.<name>.enable = lib.mkEnableOption "Enable <name>";

  config = lib.mkIf cfg.enable {
    # Home Manager config here
  };
}
```

Home Manager module with `enable` and `package`:

```nix
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.<category>.<name>;
in
{
  options.myHome.<category>.<name> = {
    enable = lib.mkEnableOption "Enable <name>";
    package = lib.mkPackageOption pkgs "<package-name>" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    # or programs.<name>.package = cfg.package;
  };
}
```

System module with `enable`:

```nix
{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.<category>.<name>;
in
{
  options.mySystem.<category>.<name>.enable = lib.mkEnableOption "Enable <name>";

  config = lib.mkIf cfg.enable {
    # nix-darwin / NixOS config here
  };
}
```

Directory aggregator `default.nix`:

```nix
{ ... }:
{
  imports = [
    ./shared
    ./<feature>
    ./<other-feature>.nix
  ];
}
```

Practical rules:

- Bind `cfg` once at the top and use `lib.mkIf cfg.enable`.
- Keep option paths aligned with the directory layout whenever practical.
- Put reusable defaults in modules; put host-specific enablement and overrides in `hosts/<hostname>/*`.
- If a module needs `pkgs-unstable`, `pkgs-darwin`, `inputs`, or `home-manager-unstable`, add only the arguments it actually uses.
- Follow nearby files for whether the option should be declared as a flat `options.foo.enable = ...` or grouped `options.foo = { enable = ...; ...; };`.
- For split system modules, define the feature shape once in `modules/os/universal/...` and let the OS-specific files implement only their platform-specific pieces.

## Where to make changes

- Add or change feature toggles in the relevant `hosts/<hostname>/home.nix` or `hosts/<hostname>/configuration.nix`.
- Add reusable Home Manager behavior in `modules/home/...`.
- Add reusable system behavior in `modules/os/universal/...` first when the feature needs a stable cross-platform entrypoint.
- Put Darwin-specific system implementation details in `modules/os/darwin/...`.
- Put NixOS-specific system implementation details in `modules/os/nixos/...`.
- Change host/user composition only when necessary in `lib.nix`.
- Touch `flake.nix` only for inputs, overlays, formatter changes, or exported configuration wiring.

## Package selection rules

- Prefer stable `pkgs` by default.
- Use `pkgs-darwin` only when working in the Darwin home/system path that already depends on it.
- Use `pkgs-unstable` only when there is a clear need and keep the reason documented inline.
- If you introduce a temporary workaround for upstream/version limitations, add a short `@upgrade` comment explaining when it can be removed.
- Avoid adding overlays unless the fix cannot be expressed cleanly at the module level.

## Editing rules for this repo

- Preserve the small-module style. Do not collapse unrelated modules into one large file.
- Match existing naming and directory layout. Examples:
  - `modules/home/utilities/<tool>.nix`
  - `modules/home/<category>/<tool>/default.nix`
  - `modules/os/darwin/sys/<feature>.nix`
- When adding a new machine, prefer creating a new `hosts/<hostname>/` directory and wiring it through `flake.nix` rather than duplicating module logic.
- Keep comments sparse and operational. Existing `@upgrade` comments are intentional and should not be removed casually.
- Keep host files thin. Put reusable logic in modules and keep `hosts/<hostname>/*` focused on selecting and configuring modules for that machine.
- Avoid changing `home.stateVersion` or `system.stateVersion` unless the user explicitly asks.

## Verification

Prefer verifying the smallest relevant target.

- Format:
  - `nix fmt`
- Evaluate flake outputs:
  - `nix flake show`
- Check a Home Manager config:
  - `home-manager build --flake '.#<user>@<hostname>'`
- Check a Darwin system config:
  - `darwin-rebuild build --flake '.#<hostname>'`
- Check a NixOS system config:
  - `nixos-rebuild build --flake '.#<hostname>'`
- Apply user config when appropriate:
  - `home-manager switch --flake '.#<user>@<hostname>'`
- Avoid applying system config through `darwin-rebuild switch` or `nixos-rebuild switch` unless the user explicitly asks, since that is a privileged machine-level change.
- Avoid evaluating changes with `nix eval`, since the sandbox will reject the command.

If a change is isolated to one module, prefer `build` over `switch`.

## Practical notes

- User identity defaults are defined in `lib.nix` via `mkUser`; reuse those values instead of hardcoding username/email/home paths in modules.
- This repo already uses both `home-manager` and `home-manager-unstable`; follow the existing pattern when importing newer upstream modules.
- Keep architecture-specific assumptions explicit in modules and host wiring; do not assume all hosts share the same platform.
- If `git status` fails due to fsmonitor IPC issues, use:
  - `git -c core.fsmonitor=false status`
