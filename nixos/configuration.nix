# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";  # disables NM DNS handling
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex = {
    isNormalUser = true;
    description = "alex";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    stow
    i3status-rust
    fuzzel
    eza
    fd
    ripgrep
    delta
    brightnessctl
  ];

  home-manager.users.alex = {
        home.stateVersion = "25.05";

        programs.neovim = {
            enable = true;
            defaultEditor = true;
            plugins = with pkgs; [
                vimPlugins.kanagawa-nvim
                vimPlugins.fzf-lua
                vimPlugins.blink-cmp
            ];
        };
        programs.git.enable = true;
        programs.firefox.enable = true;
        programs.fish = {
          enable = true;
          shellInit = builtins.readFile ../.config/fish/config.fish;
          plugins = [
            {
              name = "pure";
              src = pkgs.fishPlugins.pure.src;
            }
          ];
        };
        programs.foot.enable = true;

        home.file.".config/nvim/init.lua".source = ../.config/nvim/init.lua;
        home.file.".config/foot/foot.ini".source = ../.config/foot/foot.ini;
        home.file.".config/sway/config".source = ../.config/sway/config;
        home.file.".config/i3status-rust/config.toml".source = ../.config/i3status-rust/config.toml;
        home.file.".gitconfig".source = ../.gitconfig;
  };

  programs.sway.enable = true;

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts.monospace = [
    "JetBrains Mono"
  ];

  # List services that you want to enable:
  services.auto-cpufreq.enable = true;

  services.xserver = {
    enable = false;
    xkb = {
      layout = "es";
      # options = "caps:swapescape,ctrl:swap_lalt_lctl";
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
