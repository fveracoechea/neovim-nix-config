{...}: {
  xdg.configFile."nvim/snippets/global.json".text = builtins.toJSON {
    log = {
      prefix = "log";
      body = ["console.log($1);"];
      description = "Log output to console";
    };
    "arrow function" = {
      prefix = "af";
      body = ["const $1 = ($2) => {" "  $3" "}"];
      description = "Arrow function";
    };
  };
}
