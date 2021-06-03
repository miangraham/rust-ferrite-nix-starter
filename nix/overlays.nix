let
  sources = import ./sources.nix;
  oxa-overlay = import sources.oxalica-overlay;
  rust-overlay = self: super:
    let channel = super.rust-bin.stable."1.52.1".default;
    in
      {
        cargo = channel;
        rustc = channel;
      };
in
[ oxa-overlay rust-overlay ]
