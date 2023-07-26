{
  description = "Small scripts that don't deserve their own repo.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = with pkgs; {
          snippet = writeShellApplication {
            name = "snippet";
            runtimeInputs = [ bat fd fzf ];
            text = (builtins.readFile ./src/snippet.sh);
          };
          command-runner = writeShellApplication {
            name = "command-runner";
            runtimeInputs = [ comma libnotify tofi ];
            text = (builtins.readFile ./src/command-runner.sh);
          };
        };
      }
    );
}
