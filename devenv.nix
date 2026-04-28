{pkgs, ...}: {
  # https://devenv.sh/packages/
  packages = with pkgs; [
    gopls
  ];

  # https://devenv.sh/languages/
  languages.go = {
    enable = true;
    enableHardeningWorkaround = true;
    version = "1.25.9";
  };

  dotenv = {
    enable = true;
    filename = [
      # ".testenv/kopia-std.env"
      # ".testenv/storage-test.env"
      # "repo/blob/storj/testdata/nas11@rctestenv-kopiatest-2023-08-17T13_49_24.469Z.env"
      # ".testenv/dev@rctestenv-20250321.env"
    ];
  };

  env = {
    GOTOOLCHAIN = "local"; # prevent go from messing with go.mod regarding go/toolchain version
    hardeningDisable = ["all"]; # needed for any GOGCC stuff under nix
  };

  enterShell = ''
    echo -e "Now in \e[3m\e[32mdevenv\e[0m \e[36mdevShell\e[0m..."
    go version
    go env -w GOTOOLCHAIN=local
    go env -w GONOSUMDB="g1tlab.1nnov8.de/*,rain.cloud/*"
    if ping -c1 ryzerv.1nnov8.eu >/dev/null 2>&1; then
       go env -w GOPROXY="http://ryzerv.1nnov8.eu:3000,direct"
    fi;
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  # enterTest = '''';
}
