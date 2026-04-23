{ lib, modulesPath, ... }:
{
  imports = lib.map (m: "${modulesPath}/" + m) [
    # modules i explicitly use myself
    "programs/difftastic.nix"
    "programs/eza.nix"
    "programs/ghostty.nix"
    "programs/git.nix"
    "programs/helix.nix"
    "programs/jujutsu.nix"
    "programs/librewolf.nix"
    "programs/mpv.nix"
    "programs/nix-index.nix"
    "programs/quickshell.nix"
    "programs/vesktop.nix"
    "programs/vim.nix"
    "programs/zoxide.nix"
    "services/home-manager-auto-expire.nix"
    "services/nix-gc.nix"

    # required by other modules
    "programs/bat.nix" # ghostty
    "programs/command-not-found" # nix-index
    "programs/delta.nix" # git
    "programs/diff-highlight.nix" # git
    "programs/diff-so-fancy.nix" # git
    "programs/fish.nix" # zoxide
    "programs/home-manager.nix" # auto-expire
    "programs/man.nix" # fish
    "programs/patdiff.nix" # git
    "programs/riff.nix" # git
    "services/gpg-agent.nix" # ssh-auth-sock
    "services/proton-pass-agent.nix" # ssh-auth-sock
    "services/ssh-agent.nix" # ssh-auth-sock
    "services/ssh-tpm-agent.nix" # ssh-auth-sock
    "services/yubikey-agent.nix" # ssh-auth-sock
  ];
}
