{
  description = "Minecraft modpacks workspace";

  inputs = {
    huroshiki.url = "github:upiscium/Huroshiki";
    nixpkgs.follows = "huroshiki/nixpkgs";
  };

  outputs = { huroshiki, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [
              huroshiki.packages.${system}.huroshiki
            ];
          };
        });
    };
}
