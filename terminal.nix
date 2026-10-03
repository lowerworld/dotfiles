{
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    programs = {
      ghostty = {
        enable = true;
        settings = {
          font-family = [
            "0xProto Nerd Font"
            "Migu 1M"
          ];

          font-feature = "-calt, -liga, -dlig";
          font-size = 16;

          adjust-cell-height = 2;
          adjust-underline-thickness = -1;
          adjust-strikethrough-thickness = -1;
          adjust-overline-thickness = -1;
          adjust-icon-height = "-25%";

          theme = "0x96f";

          background = "black";

          cursor-style-blink = false;

          mouse-hide-while-typing = true;

          background-opacity = 0.85;
          background-opacity-cells = true;
          background-blur = 5;

          maximize = true;

          window-padding-x = 5;
          window-padding-y = 5;
          window-padding-balance = true;

          shell-integration-features = "no-cursor";

          macos-titlebar-style = "tabs";
          macos-option-as-alt = true;

          bold-color = "bright";

          keybind = [
            "alt+arrow_left=unbind"
            "alt+arrow_right=unbind"

            "cmd+page_up=previous_tab"
            "cmd+page_down=next_tab"
          ];
        };
      };
    };
  };
}
