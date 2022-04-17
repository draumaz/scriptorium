{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "ncurses-rs";
  buildInputs = with pkgs;
  [pkgs.rustfmt pkgs.ncurses5];
}
