{ config, lib, ... }:
let
  cfg = config.mySystem.sys.trackpad;
in
{
  options.mySystem.sys.trackpad.enable = lib.mkEnableOption "Configure trackpad";

  config = lib.mkIf cfg.enable {
    system = {
      defaults = {
        trackpad = {
          # Tap to click
          Clicking = true;
          # Tap to drag
          Dragging = true;
          # 4-finger swipe
          # TrackpadFourFingerHorizSwipeGesture = 2;
          # 2-finger right click
          TrackpadRightClick = true;
          # Drag with 3 fingers
          TrackpadThreeFingerDrag = true;
        };
      };
    };
  };
}
