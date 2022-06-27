lua << EOF
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
        ["<esc>"] = require("telescope.actions").close,
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
      "--hidden"
    },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      width = 0.9
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
EOF

" ------- mappings

" fuzzey find in current buffer
" use <ctrl+v> and then press '/'. This gives '_'. So the we put '_' here
" the actual mapping is <C-/>
nnoremap <C-_> :Telescope current_buffer_fuzzy_find<CR>

" search buffer list
nnoremap <leader>; :Telescope buffers<CR>

" searching files
nnoremap <leader>ff :Telescope find_files hidden=true<CR>

" live grep
nnoremap <leader>fg :Telescope live_grep<CR>

" help tags
nnoremap <leader>fh :Telescope help_tags<CR>

