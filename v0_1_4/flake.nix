{
  description = ''Nim wrapper around librtlsdr.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-rtlsdr-v0_1_4.flake = false;
  inputs.src-rtlsdr-v0_1_4.ref   = "refs/tags/v0.1.4";
  inputs.src-rtlsdr-v0_1_4.owner = "jpoirier";
  inputs.src-rtlsdr-v0_1_4.repo  = "nimrtlsdr";
  inputs.src-rtlsdr-v0_1_4.dir   = "";
  inputs.src-rtlsdr-v0_1_4.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-rtlsdr-v0_1_4"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-rtlsdr-v0_1_4";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}