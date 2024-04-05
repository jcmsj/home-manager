{
  description = "Home Manager configuration of jcsan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # add ags
    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, home-manager, ags, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
	home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      homeConfigurations."jcsan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
	 
        # the path to your home.nix.
        modules = [
          ./home.nix
          ags.homeManagerModules.default  # another could be ags
         ];

      };
    };
}
