{
  description = ''Nim wrapper around librtlsdr.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-rtlsdr-develop.flake = false;
  inputs.src-rtlsdr-develop.ref   = "refs/heads/develop";
  inputs.src-rtlsdr-develop.owner = "jpoirier";
  inputs.src-rtlsdr-develop.repo  = "nimrtlsdr";
  inputs.src-rtlsdr-develop.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-rtlsdr-develop"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-rtlsdr-develop";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}