{ pkgs, ... }:

{

  home.packages = with pkgs; [
    nodejs
    jq
  ];

  programs.claude-code = {
    enable = true;

    settings = {
      theme = "dark";
      includeCoAuthoredBy = false;
      model = "claude-sonnet-4-5-20250929";

      permissions = {
        defaultMode = "acceptEdits";
        allow = [
          "Bash(git diff:*)"
          "Bash(nix fmt *)"
          "Edit(*nix)"
          "Read(./Claude.md)"
        ];
        ask = [
          "Bash(git push:*)"
          "Bash(rm *)"
          "Bash(nix-collect-garbage*)"
        ];
        deny = [
          "WebFetch"
          "Bash(curl:*)"
          "Read(*/.env)"
          "Read(*/.ssh/*)"
          "Read(*/.secrets/**)"
        ];
      };

      statusLine = {
        type = "command";
        command = ''
          read -r input
          DIR=$(echo "$input" | jq -r '.workspace.current_dir | split("/") | last')
          echo -e "\033[1;35m[Claude]\033[0m $DIR"
        '';
      };

      hooks.PostToolUse = [
        {
          matcher = "Edit|Write";
          hooks = [
            {
              type = "command";
              command = ''
                FILE=$(jq -r '.tool_input.file_path' <<< "$CLAUDE_TOOL_INPUT")
                if [[ "$FILE" == *.nix ]]; then nix fmt "$FILE" || true; fi
              '';
            }
          ];
        }
      ];
    };

    memory.text = ''
      # Identity
      - Name: Developer
      - Environment: NixOS Unstable / Home Manager / Devenv
      - Communication: Succinct, techincal, avoid pleasantries.

      # System Safety
      - Never modify /etc/ or ~/.dotfiles/ directly.
      - Always suggest declaritive Nix code changes instead.
      - Respect .gitignore strictly
    '';

    rules = {
      code-style = ''
        # Code Style Guidelines

        - Use consistent formatting
        - Follow language conventions
      '';
      testing = ''
        # Testing Conventions

        - Focus tests on edge cases and complex logic.
        - Use 'devenv shell test' for CI-equivalent local checks.
      '';
    };
  };

}
