{
  pkgs,
  config,
  ...
}: let
  nix-theme = pkgs.callPackage ./nix-theme.nix {inherit config;};
in {
  home.packages = [pkgs.emacs-all-the-icons-fonts];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;

    extraPackages = epkgs:
      with epkgs; [
        # ui
        doom-modeline
        nix-theme
        all-the-icons
        dashboard
        vertico

        # programming
        nix-mode
        go-mode
        zig-mode
        lsp-pyright

        # lsp
        orderless
        corfu
        eglot

        # tools
        org
        direnv
        magit
        vterm
      ];

    extraConfig = ''
      (progn ; ui
        ;; disable some stuff
        (menu-bar-mode -1)
        (scroll-bar-mode -1)
        (tool-bar-mode -1)

        ;; enable truncate lines
        (setq truncate-lines t)

        ;; font
        (set-face-attribute 'default nil :font "${config.fontProfiles.monospace.family}")
        (add-to-list 'default-frame-alist '(font . "${config.fontProfiles.monospace.family}-10"))

        ;; line numbers
        (global-display-line-numbers-mode)

        ;; tab width
        (setq-default tab-width 4)

        ;; theme
        (load-theme 'base16-${config.colorscheme.slug} t)

        ;; modeline
        (require 'doom-modeline)
        (doom-modeline-mode)

        ;; dashboard
        (require 'dashboard)
        (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
        (dashboard-setup-startup-hook)

        ;; vertico
        (require 'vertico)
        (vertico-mode))

      (progn ; keybindings
        ;; IBuffer
        (global-set-key (kbd "C-x C-b") 'ibuffer))

      (progn ; programming
        ;; python
        (require 'lsp-pyright)
        (setq lsp-pyright-auto-import-completions t
              lsp-pyright-use-library-code-for-types t)
        (add-hook 'python-mode-hook (lambda () (lsp)))

        ;; go
        (require 'go-mode)
        (add-hook 'go-mode-hook 'eglot-ensure)

        ;; zig
        (require 'zig-mode)
        (add-hook 'zig-mode-hook 'eglot-ensure)

        ;; direnv
        (require 'direnv)
        (direnv-mode)

        ;; orderless
        (require 'orderless)
        (setq completion-styles '(orderless flex)
              cempletion-category-overrides '(eglot (styles . (orderless-flex))))

        ;; corfu
        (require 'corfu)
        (setq corfu-auto t)
        (global-corfu-mode)

        ;; eglot
        (require 'eglot)
        (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1))))
    '';
  };

  services.emacs = {
    enable = true;
    package = config.programs.emacs.finalPackage;
  };

  programs.git.ignores = [
    "#*#"
    "*~"
    ".*#"
  ];
}
