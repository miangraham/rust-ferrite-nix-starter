let
  sources = import ./nix/sources.nix;
  overlays = import ./nix/overlays.nix;
  pkgs = import sources.nixpkgs { inherit overlays; };
  cargo_nix = pkgs.callPackage ./Cargo.nix { inherit pkgs; };
in
cargo_nix.rootCrate.build
