# flake.nix
{
  description = "mirror's personal flake wow";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    tochd-src = {
      url = "github:thingsiplay/tochd";
      flake = false;
    };
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    home-manager,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {
        system,
        pkgs,
        inputs',
        self',
        ...
      }: {
        packages = {
          firefoxFull = import ./modules/firefox {
            inherit pkgs;
            prefProfiles = ["base"];
            extensionProfiles = ["base" "yomitan" "proton"];
          };
          firefoxLite = import ./modules/firefox {
            inherit pkgs;
            prefProfiles = ["base"];
            extensionProfiles = ["base"];
          };
          firefoxHardened = import ./modules/firefox {
            inherit pkgs;
            prefProfiles = ["base" "hardened"];
            extensionProfiles = ["base" "yomitan" "proton"];
          };
          firefoxParanoid = import ./modules/firefox {
            inherit pkgs;
            prefProfiles = ["base" "hardened" "paranoid"];
            extensionProfiles = ["base" "yomitan" "paranoid"];
          };
          firefoxLiteParanoid = import ./modules/firefox {
            inherit pkgs;
            prefProfiles = ["base" "hardened" "paranoid"];
            extensionProfiles = ["base" "paranoid"];
          };
          firefoxLiteHardened = import ./modules/firefox {
            inherit pkgs;
            prefProfiles = ["base" "hardened"];
            extensionProfiles = ["base"];
          };
          tochd = pkgs.callPackage ./modules/rom-manager {
            src = inputs'.tochd-src;
          };
        };
        apps = {
          tochd = {
            type = "app";
            program = "${self'.packages.tochd}/bin/tochd";
          };
        };
      };

      flake.nixosConfigurations.casket = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            _module.args.firefoxHardened = inputs.self.packages."x86_64-linux".firefoxHardened;
            _module.args.tochd = inputs.self.packages."x86_64-linux".tochd;
          }

          ./hosts/casket/configuration.nix
          ./hosts/casket/hardware-configuration.nix
          ./modules/common.nix
          ./modules/fun.nix
          ./modules/linux-firmware.nix
          ./modules/dev/dev.nix
          ./modules/hardware/thermal_printers.nix
          ./modules/cad.nix
          ./modules/wine.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.mirror = import ./hosts/casket/home.nix;
          }
        ];
      };
    };
}
