{pkgs, ...}: {
  # show what package provides a commands when it's not found
  programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    # run commands without installing them
    # , <cmd>
    nix-index-database.comma.enable = true;
  };

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^[j" "^[[A"];
      searchDownKey = ["^[k" "^[[B"];
    };

    shellAliases = {
      ls = "ls --color=auto";
      mv = "mv -iv";
      rm = "rm -I";
      cp = "cp -iv";
      ln = "ln -iv";
      please = "sudo $(fc -ln -1)";
      lf = "lfub";
      gs = "git status";
      gd = "git diff";
      ga = "git add";
      ssh = "TERM=xterm-256color ssh";
      "cd ..." = "cd ../..";
      "cd ...." = "cd ../../..";
      neofetch = ''
        fastfetch \
        --structure "Title:Separator:OS:Host:Kernel:Uptime:Packages:Shell:Display:DE:WM:WMTheme:Theme:Icons:Terminal:TerminalFont:CPU:GPU:Memory:Break:Colors" \
        --os-format "{3} {12}" \
        --memory-format "{/1}{-}{/}{/2}{-}{/}{} / {}"
      '';
    };

    envExtra = ''
      typeset -U path PATH
      path+=$HOME/bin
      path+=$HOME/bin/rofi
      path+=$HOME/bin/status
      export PATH
    '';

    sessionVariables = {
      TERMINAL = "wezterm";
      EDITOR = "nvim";
      LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate dracula)";
    };

    history = {
      size = 1000000;
      save = 1000000;
      ignorePatterns = ["cd ..*" "ls"];
      extended = true;
    };

    defaultKeymap = "emacs";
    initExtra = ''
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
    '';

    profileExtra = ''
      if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        startx
      fi
    '';
  };
}
