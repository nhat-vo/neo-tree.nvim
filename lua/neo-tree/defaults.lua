local config = {

  --- SOURCES ---
  --- Here you can define which sources to be loaded. By default, the 
  --- "filesystem", "buffers", and "git_status" sources are enabled.
  --- You can also choose to add external sources, which are available 
  --- at https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/External-Sources.
  sources = {
    "filesystem",         -- Provide file explorer functionality
    "buffers",            -- Show a list of opened buffers
    "git_status",         -- Show the git status of files in the directory
    -- "document_symbols",   -- (Experimental) Lists the LSP symbols in the buffer
  },
  --- You can define which source will be opened by default if no source is specified.
  default_source = "filesystem",



  --- MAPPINGS ---
  use_default_mappings = true,          -- add default mappings. If this is turned off, only the mappings explicitly defined by the user will be active.
  close_floats_on_escape_key = true,    -- all floating windows can be closed with `<esc>`


  --- ENABLE/DISABLE FEATURES ---
  --- Here is a list of features that can be enabled/disabled

  -- Automatically clean up broken neo-tree buffers. This is useful if you work with sessions, which
  -- could restore a rogue empty neo-tree buffer and prevent neo-tree from opening.
  auto_clean_after_session_restore = false,

  close_if_last_window = false,   -- Close Neo-tree if it is the last window left in the tab
  enable_diagnostics = true,      -- Enable diagnostics icons.
  enable_git_status = true,       -- Enable git status icons.
  enable_modified_markers = true, -- Show markers for files with unsaved changes.
  enable_opened_markers = true,   -- Enable tracking of opened buffers. Required for `components.name.highlight_opened_files`
  enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.



  --- GIT STATUS ---
  --- These are configurations specific to interacting with git.
  --- They are meant to be used by users with very big git repos.

  git_status_async = true,  -- Make git status run asynchronously.
  git_status_async_options = {
    batch_size = 1000, -- how many lines of git status results to process at a time
    batch_delay = 10,  -- delay in ms between batches. Spreads out the workload to let other processes run.
    max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
                       -- Anything before this will be used. The last items to be processed are the untracked files.
  },


  --- RENDERING ---
  --- These controls the display of neo-tree.
  add_blank_line_at_top = false,  -- Add a blank line at the top of the tree.
  hide_root_node = false,         -- Hide the root node.

  -- IF the root node is hidden, keep the indentation anyhow.
  -- This is needed if you use expanders because they render in the indent.
  retain_hidden_root_indent = false,

  -- popup_border_style is for input and confirmation dialogs.
  -- Configurtaion of floating window is done in the individual source sections.
  -- "NC" is a special style that works well with NormalNC set
  popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
  use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.


  --- LOGGING ---
  --- Controls the logging of the plugin.
  log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
  log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file


  -- OTHER BEHAVIORS --
  open_files_in_last_window = true, -- false = open files in top left window
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes

  -- in ms, needed for containers to redraw right aligned and faded content
  -- set to -1 to disable the resize timer entirely
  -- NOTE: this will speed up to 50 ms for 1 second following a resize
  resize_timer_interval = 500,


  -- You can define rules on how files should be sorted or nested.
  nesting_rules = {},
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  sort_function = nil , -- uses a custom function for sorting files and directories in the tree


  -- GLOBAL CUSTOM COMMANDS that will be available in all sources (if not overridden in `opts[source_name].commands`)
  --
  -- You can then reference the custom command by adding a mapping to it:
  --    globally    -> `opts.window.mappings`
  --    locally     -> `opt[source_name].window.mappings` to make it source specific.
  --
  -- commands = {              |  window {                 |  filesystem {
  --   hello = function()      |    mappings = {           |    commands = {
  --     print("Hello world")  |      ["<C-c>"] = "hello"  |      hello = function()
  --   end                     |    }                      |        print("Hello world in filesystem")
  -- }                         |  }                        |      end
  --
  -- see `:h neo-tree-global-custom-commands`
  commands = {}, -- A list of functions


  --- SOURCE SELECTOR ---
  --- These settings concerns the source selector, which shows and allows you to select between the sources.
  source_selector = {
    winbar = false, -- toggle to show selector on winbar
    statusline = false, -- toggle to show selector on statusline
    show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
                                           -- of the top visible node when scrolled down.
    --
    -- Here you can control which source should be rendered.
    sources = {
      { source = "filesystem" },
      { source = "buffers" },
      { source = "git_status" },
    },

    -- only with `tabs_layout` = "equal", "focus"
    --   start  : |/ 裡 bufname     \/...
    --   end    : |/     裡 bufname \/...
    --   center : |/   裡 bufname   \/...
    content_layout = "start",

    -- start, end, center, equal, focus
    --   start  : |/  a  \/  b  \/  c  \            |
    --   end    : |            /  a  \/  b  \/  c  \|
    --   center : |      /  a  \/  b  \/  c  \      |
    --   equal  : |/    a    \/    b    \/    c    \|
    --   active : |/  focused tab    \/  b  \/  c  \|
    tabs_layout = "equal",

    truncation_character = "…", -- character to use when truncating the tab label
    tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
    tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`

    padding = 0, -- can be int or table
    -- padding = { left = 2, right = 0 },

    -- separator = "▕", -- can be string or table, see below
     separator = { left = "▏", right= "▕" },
    -- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
    -- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
    -- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
    -- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
    -- separator = "|",                                              -- ||  a  |  b  |  c  |...
    separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
    show_separator_on_edge = false,
    --                       true  : |/    a    \/    b    \/    c    \|
    --                       false : |     a    \/    b    \/    c     |

    highlight_tab = "NeoTreeTabInactive",
    highlight_tab_active = "NeoTreeTabActive",
    highlight_background = "NeoTreeTabInactive",
    highlight_separator = "NeoTreeTabSeparatorInactive",
    highlight_separator_active = "NeoTreeTabSeparatorActive",
  },

  --- EVENT HANDLERS ---
  --- You can add custom commands to be run after each events. A complete list of 
  --- events can be found in :h neo-tree-events
  -- event_handlers = {
  --   {
  --     event = "before_render",
  --     handler = function (state)
  --       -- add something to the state that can be used by custom components
  --     end
  --   },
  --   {
  --     event = "file_opened",
  --     handler = function(file_path)
  --       --auto close
  --       require("neo-tree").close_all()
  --     end
  --   },
  --   {
  --     event = "file_opened",
  --     handler = function(file_path)
  --       --clear search after opening a file
  --       require("neo-tree.sources.filesystem").reset_search()
  --     end
  --   },
  --   {
  --     event = "file_renamed",
  --     handler = function(args)
  --       -- fix references to file
  --       print(args.source, " renamed to ", args.destination)
  --     end
  --   },
  --   {
  --     event = "file_moved",
  --     handler = function(args)
  --       -- fix references to file
  --       print(args.source, " moved to ", args.destination)
  --     end
  --   },
  --   {
  --     event = "neo_tree_buffer_enter",
  --     handler = function()
  --       vim.cmd 'highlight! Cursor blend=100'
  --     end
  --   },
  --   {
  --     event = "neo_tree_buffer_leave",
  --     handler = function()
  --       vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
  --     end
  --   },
  --   {
  --     event = "neo_tree_window_before_open",
  --     handler = function(args)
  --       print("neo_tree_window_before_open", vim.inspect(args))
  --     end
  --   },
  --   {
  --     event = "neo_tree_window_after_open",
  --     handler = function(args)
  --       vim.cmd("wincmd =")
  --     end
  --   },
  --   {
  --     event = "neo_tree_window_before_close",
  --     handler = function(args)
  --       print("neo_tree_window_before_close", vim.inspect(args))
  --     end
  --   },
  --   {
  --     event = "neo_tree_window_after_close",
  --     handler = function(args)
  --       vim.cmd("wincmd =")
  --     end
  --   }
  -- },



  --- COMPONENTS ---
  --- Neo-tree is rendered using components. Here you can add configurations to default components provided by neo-tree.
  default_component_configs = {

    -- Containers represents a group of components. They can span the remaining width of the window, and allows 
    -- advanced layouts such as right align and overlapping. See :h neo-tree-container
    container = {
      enable_character_fade = true,   -- If true, will fade out overlapped characters
      width = "100%",                 -- Control how much of the remaining width this will take up
      right_padding = 0,
    },

    -- The diagnostics component shows diagnostic counts in the tree.
    -- You can specify the symbols and highlight groups here.
    -- diagnostics = {
    --  symbols = {
    --    hint = "H",
    --    info = "I",
    --    warn = "!",
    --    error = "X",
    --  },
    --  highlights = {
    --    hint = "DiagnosticSignHint",
    --    info = "DiagnosticSignInfo",
    --    warn = "DiagnosticSignWarn",
    --    error = "DiagnosticSignError",
    --  },
    -- },

    -- The indent component adds indentation to the tree to create a hierarchy effect.
    indent = {
      indent_size = 2,
      padding = 1,

      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",

      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },

    -- The icon component adds icons to the tree to show the type of files and folders.
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "ﰊ",
      folder_empty_open = "ﰊ",

      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon"
    },

    -- The highlight component adds a marker to modified files.
    modified = { symbol = "[+] ", highlight = "NeoTreeModified" },

    -- Inevitable to any tree, the filename component shows the name of the files and folders.
    name = {
      trailing_slash = false,           -- Append a trailing slash to folder names
      use_git_status_colors = true,     -- Highlight with git status
      highlight = "NeoTreeFileName",    -- Highlight group used for the filename (without git status)

      -- Requires `enable_opened_markers = true`.
      -- Take values in { false (no highlight), true (only loaded),
      -- "all" (both loaded and unloaded)}. For more information,
      -- see the `show_unloaded` config of the `buffers` source.
      highlight_opened_files = false,
    },

    -- The git_status component shows a diff marker next to files that are staged, unstaged, etc.
    git_status = {
      symbols = {
        -- Change type
        added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
        deleted   = "✖",
        modified  = "",
        renamed   = "",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      },
      align = "right",
    },
  },





  --- RENDERER ---
  --- This controls how the tree is rendered based on the components listed above.
  ---   The first level key is the node type.
  ---   For each node type, you can specify a list of components to render.
  ---     Components are rendered in the order they are specified.
  ---     The first field in each component is the name of the function to call.
  ---     The rest of the fields are passed to the function as the "config" argument.
  ---     For more informations, see :h neo-tree-renderers and :h neo-tree-components
  renderers = {
    directory = {
      { "indent" }, { "icon" }, { "current_filter" },
      {
        "container",
        content = {
          { "name", zindex = 10 },
          -- { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
          { "clipboard", zindex = 10 },
          { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
          { "git_status", zindex = 20, align = "right", hide_when_expanded = true },
        },
      },
    },
    file = {
      { "indent" }, { "icon" },
      {
        "container",
        content = {
          { "name", zindex = 10 },
          -- { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
          { "clipboard", zindex = 10 },
          { "bufnr", zindex = 10 },
          { "modified", zindex = 20, align = "right" },
          { "diagnostics",  zindex = 20, align = "right" },
          { "git_status", zindex = 20, align = "right" },
        },
      },
    },
    message = {
      { "indent", with_markers = false },
      { "name", highlight = "NeoTreeMessage" },
    },
    terminal = { { "indent" }, { "icon" }, { "name" }, { "bufnr" } },
  },




  --- WINDOW ---
  --- This specifies the window options for the tree window, as well as the global mappings.
  window = {
    -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
    -- possible options. These can also be functions that return these options.
    position = "left", -- left, right, top, bottom, float, current
    width = 40, -- applies to left and right positions
    height = 15, -- applies to top and bottom positions
    auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
    popup = { -- settings that apply to float position only
      size = { height = "80%", width = "50%" },
      position = "50%", -- 50% means center it
      -- you can also specify border here, if you want a different setting from
      -- the global popup_border_style.
    },
    same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
    insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
                        -- "child":   Insert nodes as children of the directory under cursor.
                        -- "sibling": Insert nodes  as siblings of the directory under cursor.
    -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
    -- You can also create your own commands by providing a function instead of a string.


    --- GLOBAL MAPPINGS ---
    mapping_options = { noremap = true, nowait = true },

    -- Each entry maps from a key to a command name (built-in or defined in config.command) or a function.
    -- You can also map a key to "noop" to disable the default mapping. Each command will be called with
    -- the "state" argument, which stores all information about the tree. 
    -- See https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#commands for how to write commands.
    mappings = {
      ["<space>"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "revert_preview",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      -- ["S"] = "split_with_window_picker",
      ["s"] = "open_vsplit",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      ["R"] = "refresh",
      ["a"] = {
        "add",
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        }
      },
      ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
      ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
      ["e"] = "toggle_auto_expand_width",
      ["q"] = "close_window",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },





  --- The rest of this file concerns how to setup source-specific options. Each source'config
  --- are specified with the key as its own name.

  --- FILE SYSTEM SOURCE ---
  filesystem = {

    -- For each source, you can also define your own components (to be added to the renderer). 
    -- See :h neo-tree-components and https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#components 
    -- for details on how to write your own components.
    components = {},

    window = {
      mappings = {
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      },

      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
      },
    },

    async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
                                   -- "always" means directory scans are always async.
                                   -- "never"  means directory scans are never async.

    scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
                           -- "deep": Scan into directories to detect empty or grouped empty directories a priori.

    bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
    cwd_target = {
      sidebar = "tab",   -- sidebar is when position = left or right
      current = "window" -- current is when position = current
    },

    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
      show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        ".DS_Store",
        "thumbs.db"
        --"node_modules",
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json"
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
                                      -- `true` will change the filter into a full path
                                      -- search with space as an implicit ".*", so
                                      -- `fi init`
                                      -- will match: `./sources/filesystem/init.lua

    -- find_command = "fd", -- this is determined automatically, you probably don't need to set it
    -- find_args = {  -- you can specify extra args to pass to the find command.
    --  fd = {
    --    "--exclude", ".git",
    --    "--exclude",  "node_modules"
    --  }
    -- },
    -- -- or use a function instead of list of strings
    -- find_args = function(cmd, path, search_term, args)
    --  if cmd ~= "fd" then
    --    return args
    --  end
    --  --maybe you want to force the filter to always include hidden files:
    --  table.insert(args, "--hidden")
    --  -- but no one ever wants to see .git files
    --  table.insert(args, "--exclude")
    --  table.insert(args, ".git")
    --  -- or node_modules
    --  table.insert(args, "--exclude")
    --  table.insert(args, "node_modules")
    --  --here is where it pays to use the function, you can exclude more for
    --  --short search terms, or vary based on the directory
    --  if string.len(search_term) < 4 and path == "/home/cseickel" then
    --    table.insert(args, "--exclude")
    --    table.insert(args, "Library")
    --  end
    --  return args
    -- end,

    group_empty_dirs = false, -- when true, empty folders will be grouped together
    search_limit = 50, -- max number of search results when using filters
    follow_current_file = false, -- This will find and focus the file in the active buffer every time
                                 -- the current file is changed while the tree is open.
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                            -- in whatever position is specified in window.position
                          -- "open_current",-- netrw disabled, opening a directory opens within the
                                            -- window like netrw would, regardless of window.position
                          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                    -- instead of relying on nvim autocmd events.
  },




  --- BUFFER SOURCE ---
  buffers = {
    bind_to_cwd = true,
    follow_current_file = true, -- This will find and focus the file in the active buffer every time
                                -- the current file is changed while the tree is open.
    group_empty_dirs = true,  -- when true, empty directories will be grouped together
    show_unloaded = false,    -- When working with sessions, for example, restored but unfocused buffers
                              -- are mark as "unloaded". Turn this on to view these unloaded buffer.
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["bd"] = "buffer_delete",
      },
    },
  },





  --- GIT STATUS SOURCE ---
  git_status = {
    window = {
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },




  --- DOCUMENT SYMBOLS SOURCE ---
  document_symbols = {
    follow_cursor = false,
    client_filters = "first",
    renderers = {
      root = { {"indent"}, {"icon", default="C" }, {"name", zindex = 10} },
      symbol = {
        {"indent", with_expanders = true},
        {"kind_icon", default="?" },
        {"container",
          content = { {"name", zindex = 10}, {"kind_name", zindex = 20, align = "right"} }
        }
      },
    },
    window = {
      mappings = {
        ["<cr>"] = "jump_to_symbol",
        ["o"] = "jump_to_symbol",
        ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
        ["d"] = "noop",
        ["y"] = "noop",
        ["x"] = "noop",
        ["p"] = "noop",
        ["c"] = "noop",
        ["m"] = "noop",
        ["a"] = "noop",
      },
    },
    custom_kinds = {
      -- define custom kinds here (also remember to add icon and hl group to kinds)
      -- ccls
      -- [252] = 'TypeAlias',
      -- [253] = 'Parameter',
      -- [254] = 'StaticMethod',
      -- [255] = 'Macro',
    },
    kinds = {
      Unknown = { icon = "?", hl = "" },
      Root = { icon = "", hl = "NeoTreeRootName" },
      File = { icon = "", hl = "Tag" },
      Module = { icon = "", hl = "Exception" },
      Namespace = { icon = "", hl = "Include" },
      Package = { icon = "", hl = "Label" },
      Class = { icon = "", hl = "Include" },
      Method = { icon = "", hl = "Function" },
      Property = { icon = "", hl = "@property" },
      Field = { icon = "", hl = "@field" },
      Constructor = { icon = "", hl = "@constructor" },
      Enum = { icon = "了", hl = "@number" },
      Interface = { icon = "", hl = "Type" },
      Function = { icon = "", hl = "Function" },
      Variable = { icon = "", hl = "@variable" },
      Constant = { icon = "", hl = "Constant" },
      String = { icon = "", hl = "String" },
      Number = { icon = "", hl = "Number" },
      Boolean = { icon = "", hl = "Boolean" },
      Array = { icon = "", hl = "Type" },
      Object = { icon = "", hl = "Type" },
      Key = { icon = "", hl = "" },
      Null = { icon = "", hl = "Constant" },
      EnumMember = { icon = "", hl = "Number" },
      Struct = { icon = "", hl = "Type" },
      Event = { icon = "", hl = "Constant" },
      Operator = { icon = "", hl = "Operator" },
      TypeParameter = { icon = "", hl = "Type" },

      -- ccls
      -- TypeAlias = { icon = ' ', hl = 'Type' },
      -- Parameter = { icon = ' ', hl = '@parameter' },
      -- StaticMethod = { icon = 'ﴂ ', hl = 'Function' },
      -- Macro = { icon = ' ', hl = 'Macro' },
    }
  },




  --- EXAMPLE CUSTOM SOURCE ---
  example = {
    renderers = {
      custom = {
        {"indent"},
        {"icon", default="C" },
        {"custom"},
        {"name"}
      }
    },
    window = {
      mappings = {
        ["<cr>"] = "toggle_node",
        ["<C-e>"] = "example_command",
        ["d"] = "show_debug_info",
      },
    },
  },
}
return config
