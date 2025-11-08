{ ... }:
{
  opts = {
    autoread = true;
    autowrite = true;

    # General
    # VIM command completion. Complete longest match, then show list of possible choices.
    wildmode = "longest,list";
    # Enable and config "shared data" files
    shada = "'30,<50,s20,h";
    # Idle time before swap file is written to disk
    updatetime = 500;
    # Save undo history
    undofile = true;
    # Enable mouse support
    mouse = "a";

    # Tab control
    # Don't mix spaces and tabs
    smarttab = false;
    # The visible width of tabs
    tabstop = 4;
    # Edit as if the tabs are 4 characters wide
    softtabstop = 4;
    # Number of spaces to use for indent and unindent
    shiftwidth = 4;
    # Round indent to a multiple of 'shiftwidth'
    shiftround = true;
    # Use spaces in place of tabs anywhere, including pressing <TAB>
    expandtab = true;

    # Text Control
    # Do smart autoindenting when starting a new line.
    smartindent = true;

    # Search
    # Case insensitive searching
    ignorecase = true;
    # Case-sensitive if expresson contains a capital letter
    smartcase = true;
    # Highlight search results
    hlsearch = true;
    # Set incremental search, like modern browsers
    incsearch = true;

    # Syntax
    number = true;
    showmatch = true;
    list = true;
    # Show invisible characters
    listchars = "tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮";
    showbreak = "↪";

    # Visuals
    # Do not show "-- INSERT --", etc, on the last line.
    showmode = false;
    # 5-line buffer around the cursor when scrolling
    scrolloff = 5;
    # Enable 24-bit color
    termguicolors = true;
    # Set to dark
    background = "dark";
  };

  globals = {
    zenwritten_compat = 1;
  };
  colorscheme = "zenwritten";
}
