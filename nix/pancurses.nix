# Enter a build environment that allows
# for a successful pancurses Rust compile.
# Requires cargo to have already been installed,
# preferably locally through rustup.

{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "ncurses-rs";
  buildInputs = with pkgs;
  [pkgs.rustfmt pkgs.ncurses5];
}
