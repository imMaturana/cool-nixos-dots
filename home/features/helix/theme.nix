{ colors }: {
  "attributes" = "#${colors.base09}";
  "comment" = {
    fg = "#${colors.base03}";
    modifiers = [ "italic" ];
  };
  "constant" = "#${colors.base09}";
  "constant.character.escape" = "#${colors.base0C}";
  "constant.numeric" = "#${colors.base09}";
  "constructor" = "#${colors.base0D}";
  "debug" = "#${colors.base03}";
  "diagnostic" = { modifiers = [ "underlined" ]; };
  "diff.delta" = "#${colors.base09}";
  "diff.minus" = "#${colors.base08}";
  "diff.plus" = "#${colors.base0B}";
  "error" = "#${colors.base08}";
  "function" = "#${colors.base0D}";
  "hint" = "#${colors.base03}";
  "info" = "#${colors.base0D}";
  "keyword" = "#${colors.base0E}";
  "label" = "#${colors.base0E}";
  "namespace" = "#${colors.base0E}";
  "operator" = "#${colors.base05}";
  "special" = "#${colors.base0D}";
  "string" = "#${colors.base0B}";
  "type" = "#${colors.base0A}";
  "variable" = "#${colors.base08}";
  "variable.other.member" = "#${colors.base0B}";
  "warning" = "#${colors.base09}";

  "markup.bold" = {
    fg = "#${colors.base0A}";
    modifiers = [ "bold" ];
  };
  "markup.heading" = "#${colors.base0D}";
  "markup.italic" = {
    fg = "#${colors.base0E}";
    modifiers = [ "italic" ];
  };
  "markup.link.text" = "#${colors.base08}";
  "markup.link.url" = {
    fg = "#${colors.base09}";
    modifiers = [ "underlined" ];
  };
  "markup.list" = "#${colors.base08}";
  "markup.quote" = "#${colors.base0C}";
  "markup.raw" = "#${colors.base0B}";
  "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };

  "diagnostic.hint" = { underline = { style = "curl"; }; };
  "diagnostic.info" = { underline = { style = "curl"; }; };
  "diagnostic.warning" = { underline = { style = "curl"; }; };
  "diagnostic.error" = { underline = { style = "curl"; }; };

  "ui.background" = { bg = "#${colors.base00}"; };
  "ui.bufferline.active" = {
    fg = "#${colors.base00}";
    bg = "#${colors.base03}";
    modifiers = [ "bold" ];
  };
  "ui.bufferline" = {
    fg = "#${colors.base04}";
    bg = "#${colors.base00}";
  };
  "ui.cursor" = {
    fg = "#${colors.base0A}";
    modifiers = [ "reversed" ];
  };
  "ui.cursor.insert" = {
    fg = "#${colors.base0A}";
    modifiers = [ "revsered" ];
  };
  "ui.cursorline.primary" = {
    fg = "#${colors.base05}";
    bg = "#${colors.base01}";
  };
  "ui.cursor.match" = {
    fg = "#${colors.base0A}";
    modifiers = [ "reversed" ];
  };
  "ui.cursor.select" = {
    fg = "#${colors.base0A}";
    modifiers = [ "reversed" ];
  };
  "ui.gutter" = { bg = "#${colors.base00}"; };
  "ui.help" = {
    fg = "#${colors.base06}";
    bg = "#${colors.base01}";
  };
  "ui.linenr" = {
    fg = "#${colors.base03}";
    bg = "#${colors.base00}";
  };
  "ui.linenr.selected" = {
    fg = "#${colors.base04}";
    bg = "#${colors.base01}";
    modifiers = [ "bold" ];
  };
  "ui.menu" = {
    fg = "#${colors.base05}";
    bg = "#${colors.base01}";
  };
  "ui.menu.scroll" = {
    fg = "#${colors.base03}";
    bg = "#${colors.base01}";
  };
  "ui.menu.selected" = {
    fg = "#${colors.base01}";
    bg = "#${colors.base04}";
  };
  "ui.popup" = { bg = "#${colors.base01}"; };
  "ui.selection" = { bg = "#${colors.base02}"; };
  "ui.selection.primary" = { bg = "#${colors.base02}"; };
  "ui.statusline" = {
    fg = "#${colors.base04}";
    bg = "#${colors.base01}";
  };
  "ui.statusline.inactive" = {
    bg = "#${colors.base01}";
    fg = "#${colors.base03}";
  };
  "ui.statusline.insert" = {
    fg = "#${colors.base00}";
    bg = "#${colors.base0B}";
  };
  "ui.statusline.normal" = {
    fg = "#${colors.base00}";
    bg = "#${colors.base03}";
  };
  "ui.statusline.select" = {
    fg = "#${colors.base00}";
    bg = "#${colors.base0F}";
  };
  "ui.text" = "#${colors.base05}";
  "ui.text.focus" = "#${colors.base05}";
  "ui.virtual.indent-guide" = { fg = "#${colors.base03}"; };
  "ui.virtual.inlay-hint" = { fg = "#${colors.base01}"; };
  "ui.virtual.ruler" = { bg = "#${colors.base01}"; };
  "ui.window" = { bg = "#${colors.base01}"; };
}
