# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./laptop.nix
    ./desktop.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  console.keyMap = "de";
  services.xserver.xkb.layout = "de";

  services.xserver.enable = false;

  services.getty.autologinUser = null;
  services.greetd = {
    enable = true;
    settings.default_session.user = "greeter";
  };
  programs.regreet = {
    enable = true;
    settings = {
      skip_selection = true;
      appearance.greeting_msg = "Welcome back";
      background = {
        path = ../../wallpapers/Sunset.png;
        fit = "Cover";
      };
      GTK.application_prefer_dark_theme = true;
      widget.clock = {
        format = "%A  %H:%M";
        resolution = "1s";
        label_width = 220;
      };
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
      size = 16;
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    extraCss = ''
      window {
        color: #c0caf5;
      }

      frame.background {
        background-color: rgba(26, 27, 38, 0.92);
        border: 1px solid rgba(122, 162, 247, 0.45);
        border-radius: 18px;
        box-shadow: 0 18px 50px rgba(0, 0, 0, 0.55);
      }

      frame.background grid {
        padding: 18px;
      }

      frame.background label {
        color: #c0caf5;
      }

      entry,
      passwordentry,
      combobox button {
        min-height: 44px;
        padding: 0 14px;
        color: #c0caf5;
        background-color: rgba(22, 22, 30, 0.92);
        border: 1px solid #444b6a;
        border-radius: 10px;
        box-shadow: none;
      }

      entry:focus,
      passwordentry:focus,
      combobox button:focus {
        border-color: #2ac3de;
        box-shadow: 0 0 0 2px rgba(42, 195, 222, 0.2);
      }

      button {
        min-height: 40px;
        padding: 0 18px;
        color: #a9b1d6;
        background-color: #2f3549;
        border: 1px solid #444b6a;
        border-radius: 10px;
        box-shadow: none;
      }

      button:hover {
        color: #c0caf5;
        background-color: #444b6a;
      }

      button.suggested-action {
        color: #1a1b26;
        background-color: #2ac3de;
        border-color: #2ac3de;
        font-weight: bold;
      }

      button.suggested-action:hover {
        background-color: #7dcfff;
      }

      button.destructive-action {
        min-height: 34px;
        color: #a9b1d6;
        background-color: rgba(26, 27, 38, 0.82);
        border-color: #444b6a;
      }

      button.destructive-action:hover {
        color: #f7768e;
        border-color: #f7768e;
      }

      infobar {
        color: #c0caf5;
        background-color: rgba(22, 22, 30, 0.94);
        border: 1px solid #2ac3de;
        border-radius: 10px;
      }
    '';
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
