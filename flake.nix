{
  description = "これは全米鉄道模型協会の「標準と推奨慣例」を翻訳するプロジェクトである。";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [];
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            gettext
            python313
            nodePackages.cspell
            python313Packages.sphinx
            python313Packages.sphinx_rtd_theme
          ];
        };
        formatter = pkgs.nixpkgs;
      };
      flake = {};
    };
}
