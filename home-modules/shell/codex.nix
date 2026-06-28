{ pkgs, ... }:

{
  programs.codex = {
    enable = true;
    enableMcpIntegration = false;

    context = ''
      Start each session by orienting yourself in the current workspace before acting.

      Boundaries:
      - Work only inside the current workspace unless I explicitly approve otherwise.
      - Never use sudo.
      - Never read .env files, secrets, SSH material, or credentials.
      - Do not use the network.

      Session startup:
      - Inspect the workspace for project instructions and environment definitions before running project commands.
      - Prefer the workspace flake, devenv, or shell.nix over ad-hoc setup when one is available.
      - State which environment definition you are using before running commands that depend on it.
    '';

    settings = {
      model = "gpt-5.5";
      personality = "pragmatic";
      model_reasoning_effort = "low";

      approval_policy = "on-request";
      sandbox_mode = "workspace-write";
      web_search = "disabled";
      allow_login_shell = false;

      project_root_markers = [ ];

      shell_environment_policy = {
        "inherit" = "core";
        include_only = [
          "PATH"
          "PWD"
          "SHELL"
          "TERM"
        ];
        exclude = [
          "*TOKEN*"
          "*SECRET*"
          "*KEY*"
          "*PASSWORD*"
          "*CREDENTIAL*"
          "OPENAI_API_KEY"
          "ANTHROPIC_API_KEY"
          "GITHUB_TOKEN"
        ];
      };

      sandbox_workspace_write = {
        network_access = false;
      };
    };

    rules.default = ''
      prefix_rule(
        pattern = ["sudo"],
        decision = "forbidden",
        justification = "Never escalate privileges."
      )

      prefix_rule(
        pattern = ["nixos-rebuild"],
        decision = "forbidden",
        justification = "Never modify the host system from Codex."
      )

      prefix_rule(
        pattern = ["systemctl"],
        decision = "forbidden",
        justification = "Never manage host services from Codex."
      )

      prefix_rule(
        pattern = ["git", "push"],
        decision = "prompt",
        justification = "Ask before changing remote state."
      )

      prefix_rule(
        pattern = ["git", "commit"],
        decision = "prompt",
        justification = "Ask before creating commits."
      )

      prefix_rule(
        pattern = ["git", "rebase"],
        decision = "prompt",
        justification = "History rewriting should require approval."
      )

      prefix_rule(
        pattern = ["git", "clean", "-fdx"],
        decision = "forbidden",
        justification = "Prevent destructive cleanup."
      )

      prefix_rule(
        pattern = ["rm", "-rf"],
        decision = "prompt",
        justification = "Ask before recursive deletion."
      )
    '';
  };
}
