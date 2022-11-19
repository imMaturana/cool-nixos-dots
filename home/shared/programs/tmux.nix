{ lib, ... }:

{
  programs.tmux = {
    enable = lib.mkDefault true;
    shortcut = "a";
    terminal = "screen-256color";
    keyMode = "emacs";
    escapeTime = 0;
    extraConfig = ''
      # keybindings

      ## vim
      bind-key j select-pane -D
      bind-key l select-pane -R
      bind-key h select-pane -L
      bind-key k select-pane -U

      ## create new pane in current dir
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      ## toggle status bar
      unbind-key t
      bind-key t setw status

      # fix tmux colors
      set -ga terminal-overrides ",xterm-256color*:Tc"

      # status line

      ## erase content from left and right sides
      setw -g status-right ""
      setw -g status-left ""

      ## set transparent background
      setw -g status-style bg=default

      ## justify status
      setw -g status-justify

      ## window format
      setw -g window-status-current-format " #{window_name} "
      setw -g window-status-format " #{window_name} "

      ## window colors
      setw -g window-status-current-style bg=green,fg=black
      setw -g window-status-style bg=default,fg=white
    '';
  };
}
