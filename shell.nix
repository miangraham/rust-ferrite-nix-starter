let
  sources = import ./nix/sources.nix;
  overlays = import ./nix/overlays.nix;
  pkgs = import sources.nixpkgs { inherit overlays; };
in
pkgs.mkShell {
  buildInputs =
    builtins.attrValues {
      inherit (pkgs)
        # Standard rust tools
        rustc
        cargo

        # Needed for nix derivation build, generates Cargo.nix
        crate2nix

        # Optional dev tools as desired
        cargo-edit
        cargo-license
        clippy
        rustfmt
        rust-analyzer
      ;
    };
}
