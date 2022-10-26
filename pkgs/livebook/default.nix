{
  self,
  lib,
  beam,
  ...
}: let
  # beam.interpreters.erlangR23 is available if you need a particular version
  packages = beam.packagesWith beam.interpreters.erlangR25;
  src = builtins.fetchGit {
    url = "ssh://git@github.com/livebook-dev/livebook.git";
    #rev = "e0e80ac84440c5159b58bc3a7bd342edcd97bb74";
    rev = "eac93a47ecb33b5b71ed5ff284a42efff543d04a";
  };

in
  packages.mixRelease rec {
    inherit src;
    pname = "livebook";
    version = "0.0.0";
    #src = self; # + "/src";

    MIX_ENV = "prod";
    LIVEBOOK_COOKIE="/home/samrose/flox-livebook/COOKIE";
    # flox will create a "fixed output derivation" based on
    # the total package of fetched mix dependencies
    mixFodDeps = packages.fetchMixDeps {
      inherit version src;
      pname = "livebook";
      # nix will complain and tell you the right value to replace this with
      #sha256 = lib.fakeSha256;
      #sha256 = "sha256-5EQk4RACPTZyOF+fSnUTSHuHt6exmXkBtIyXwVay6lk=";
      sha256 = "sha256-mpZe0t1HVfC4rSbREscrpW7CfuN1SDpJd2gdAWawamk=";
      # if you have build time environment variables add them here
      #MY_VAR="value";
    };
    #buildInputs = [  beam.packages.erlangR24.elixir_1_12 ];
    #propagatedBuildInputs = [  beam.packages.erlangR24.elixir_1_12 ];
    #installPhase = ''
    #ls -al $out
    # for phoenix framework you can uncomment the lines below
    # for external task you need a workaround for the no deps check flag
    # https://github.com/phoenixframework/phoenix/issues/2690
    #mix do deps.loadpaths --no-deps-check, phx.digest
    #mix phx.digest --no-deps-check
    # mix do deps.loadpaths --no-deps-check
    #'';
  }
