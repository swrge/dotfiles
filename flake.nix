{
  description = "dotfiles: My personal Nix/NixOS configuration database.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts"; 
    nixos-flake.url = "github:srid/nixos-flake";
    treefmt.url = "github:numtide/treefmt-nix";
   };

  outputs = inputs@{
    self,
    nixpkgs,
    unstable,
    treefmt,
    flake-parts,
    ...
  }: flake-parts.lib.mkFlake {inherit inputs;} 
  ({ moduleWithSystem, ... }: {

    systems = [ "aarch64-linux" "x86_64-linux" ]; debug = true;
    
    imports = [ inputs.nixos-flake.flakeModule ];
    
    perSystem = {
      config,
      self',
      inputs',
      pkgs,
      system,
      ...
    }: {
      
      treefmt = { # formatter
        programs.alejandra.enable = true;
        flakeFormatter = true;
        projectRootFile = "flake.nix";
      };
  
    };
  });
}

