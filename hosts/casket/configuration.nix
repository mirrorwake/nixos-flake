# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  firefoxHardened,
  ...
}: let
  CURRENT_USER = "mirror";
in {
#  imports = [
#    (import ../modules/syncthing.nix {
#      CURRENT_USER = CURRENT_USER;
#    })
#      ../modules/klipper.nix
#  ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
    binfmt.emulatedSystems = ["aarch64-linux"];
  };

  networking = {
    hostName = "casket"; # Define your hostname.
    nameservers = ["8.8.8.8" "100.100.100.100" "1.1.1.1"];
    search = ["tail04574f.ts.net"];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];

  networking.networkmanager.enable = true;

  programs = {
    hyprland.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        glibc
        zlib
        libGL
      ];
    };
    nm-applet.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  security.rtkit.enable = true;

  users.users.${CURRENT_USER} = {
    isNormalUser = true;
    description = CURRENT_USER;
    extraGroups = ["networkmanager" "wheel" "dialout" "disk" "plugdev" "audio" "video" "tty" "input" "lp" "kvm" "libvrtd" "docker"];
    initialPassword = "temppass";
    packages = with pkgs; [
      vscodium-fhs
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    firefoxHardened
    dex
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" CURRENT_USER];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
  };

  environment.variables = {
    GTK_THEME = "Adwaita-dark";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "jp";
        model = "jp106";
        variant = "";
      };
      desktopManager.runXdgAutostartIfNone = true;
      videoDrivers = ["intel"];
    };
    displayManager.gdm.enable = true;
    tlp.enable = true;

    libinput.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    tailscale.enable = true;

    # === laptop specific stuff ===
    logind = {
      settings = {
        Login = {
          HandleLidSwitch = "suspend";
          HandleLidSwitchDocked = "ignore"; # only ignore if docked
          HandleLidSwitchExternalPower = "suspend";
        };
      };
    };

    udev = {
      packages = with pkgs; [
        platformio-core.udev
        libmtp # <-- make sure libmtp is included so its rules get installed
      ];

      extraRules = ''
        # Your existing USB rules
        SUBSYSTEM=="usb", ATTR{idVendor}=="0925", ATTR{idProduct}=="3881", GROUP="plugdev", MODE="0660"

        # Optional: MTP devices (Google Nexus/Pixel example)
        SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee1", GROUP="plugdev", MODE="0666"
      '';
    };
  };

  powerManagement.enable = true;
}
