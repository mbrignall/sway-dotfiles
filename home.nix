# dotfiles/home.nix
{
  home.file.".config.alacritty" = {
    source = ./alacritty;
    target = ".config/alacritty";
  };

  home.file.".config.fuzzel" = {
    source = ./fuzzel;
    target = ".config/fuzzel";
  };

  home.file.".config.gtk-3.0" = {
    source = ./gtk-3.0;
    target = ".config/gtk-3.0";
  };

  home.file.".config.mako" = {
    source = ./mako;
    target = ".config/mako";
  };

  home.file.".config.sway" = {
    source = ./sway;
    target = ".config/sway";
  };

  home.file.".config.swaylock" = {
    source = ./swaylock;
    target = ".config/swaylock";
  };

  home.file.".config.waybar" = {
    source = ./waybar;
    target = ".config/waybar";
  };
}
