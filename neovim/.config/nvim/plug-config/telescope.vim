lua << EOF
local actions = require "telescope.actions"

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      -- insert mode mappings
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ["<esc>"] = actions.close,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
    prompt_prefix = "$ ",
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--trim"  --remove indentation
    },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      width = 0.9,
      preview_width=0.40,
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require("telescope").setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}
EOF

" ------- mappings

" fuzzy find in current buffer
" use <ctrl+v> and then press '/'. This gives '_'. So the we put '_' here
" the actual mapping is <C-/>
nnoremap <C-_> :Telescope current_buffer_fuzzy_find<CR>

" search buffer list
nnoremap <leader>; :Telescope buffers<CR>

" searching files
nnoremap <leader>ff :Telescope find_files find_command=fd,--hidden,--ignore-case,--follow,--strip-cwd-prefix,--exclude,.git/,--exclude,.cache/<CR>

" live grep
nnoremap <leader>fg :Telescope live_grep<CR>

" help tags
nnoremap <leader>fh :Telescope help_tags<CR>

" workspace symbols
nnoremap <leader><S-o> :Telescope coc workspace_symbols<CR>

" telescope builtins
nnoremap <leader>b :Telescope builtin<CR>
