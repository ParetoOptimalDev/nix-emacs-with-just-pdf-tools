{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages.default = let
          myEmacsPkg = pkgs.emacs.pkgs.withPackages (epkgs: (with epkgs.melpaPackages; [
            pdf-tools
          ]));
        in myEmacsPkg;
      };
    };
}
