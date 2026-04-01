vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
local actions = require('fzf-lua.actions')

require('fzf-lua').setup({
  fzf_colors = true,
  fzf_opts = {
    ['--info']    = 'default',
    ['--layout']  = 'reverse-list',
  },
  keymap = {
    builtin = {
      ['<C-/>'] = 'toggle-help',
      ['<C-a>'] = 'toggle-fullscreen',
      ['<C-i>'] = 'toggle-preview',
    },
    fzf = {
      ['alt-s']   = 'toggle',
      ['alt-a']   = 'toggle-all',
      ['ctrl-i']  = 'toggle-preview',
    },
  },
  winopts = {
    height = 0.7,
    width  = 0.55,
    preview = {
      scrollbar = false,
      layout    = 'vertical',
      vertical  = 'up:40%',
    },
  },
  defaults = { git_icons = false },
  previewers = {
    codeaction = { toggle_behavior = 'extend' },
  },
  files = {
    winopts = {
      preview = { hidden = true },
    },
  },
  grep = {
    hidden       = true,
    rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g "!.git" -e',
    rg_glob_fn = function(query, opts)
      local regex, flags = query:match(string.format('^(.*)%s(.*)$', opts.glob_separator))
      return (regex or query), flags
    end,
  },
  helptags = {
    actions = {
      ['enter'] = actions.help_vert,
    },
  },
  lsp = {
    symbols = {},
    code_actions = {
      winopts = {
        width    = 70,
        height   = 20,
        relative = 'cursor',
        preview = {
          hidden   = true,
          vertical = 'down:50%',
        },
      },
    },
  },
  diagnostics = {
    multiline = 1,
    actions = {
      ['ctrl-e'] = {
        fn = function(_, opts)
          if opts.severity_only then
            opts.severity_only = nil
          else
            opts.severity_only = vim.diagnostic.severity.ERROR
          end
          require('fzf-lua').resume(opts)
        end,
        noclose = true,
        desc = 'toggle-all-only-errors',
        header = function(opts)
          return opts.severity_only and 'show all' or 'show only errors'
        end,
      },
    },
  },
  oldfiles = {
    include_current_session = true,
    winopts = {
      preview = { hidden = true },
    },
  },
})
