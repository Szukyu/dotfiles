vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })
require("mini.surround").setup({})
require("mini.pairs").setup({})
require("mini.notify").setup({})

local minifiles = require('mini.files')
minifiles.setup({
    mappings = {
        show_help = '?',
        go_in_plus = '<cr>',
        go_out_plus = '<tab>',
    },
    content = {
        filter = function(entry)
            return entry.fs_type ~= 'file' or entry.name ~= '.DS_Store'
        end,
        sort = function(entries)
            local function compare_alphanumerically(e1, e2)
                if e1.is_dir and not e2.is_dir then
                    return true
                end
                if not e1.is_dir and e2.is_dir then
                    return false
                end
                if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
                    return e1.digits < e2.digits
                end
                return e1.lower_name < e2.lower_name
            end

            local sorted = vim.tbl_map(function(entry)
                local pre_digits, digits = entry.name:match('^(%D*)(%d+)')
                if digits ~= nil then
                    digits = tonumber(digits)
                end

                return {
                    fs_type = entry.fs_type,
                    name = entry.name,
                    path = entry.path,
                    lower_name = entry.name:lower(),
                    is_dir = entry.fs_type == 'directory',
                    pre_digits = pre_digits,
                    digits = digits,
                }
            end, entries)
            table.sort(sorted, compare_alphanumerically)
            -- Keep only the necessary fields.
            return vim.tbl_map(function(x)
                return { name = x.name, fs_type = x.fs_type, path = x.path }
            end, sorted)
        end,
    },
    windows = { width_nofocus = 25 },
    -- Move stuff to the minifiles trash instead of it being gone forever.
    options = { permanent_delete = false },
})

-- Keep track of when the explorer is open to disable format on save.
local minifiles_explorer_group = vim.api.nvim_create_augroup('mariasolos/minifiles_explorer', { clear = true })
vim.api.nvim_create_autocmd('User', {
    group = minifiles_explorer_group,
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
        vim.g.minifiles_active = true
    end,
})
vim.api.nvim_create_autocmd('User', {
    group = minifiles_explorer_group,
    pattern = 'MiniFilesExplorerClose',
    callback = function()
        vim.g.minifiles_active = false
    end,
})

vim.api.nvim_create_autocmd('User', {
    desc = 'Notify LSPs that a file was renamed',
    pattern = { 'MiniFilesActionRename', 'MiniFilesActionMove' },
    callback = function(args)
        local changes = {
            files = {
                {
                    oldUri = vim.uri_from_fname(args.data.from),
                    newUri = vim.uri_from_fname(args.data.to),
                },
            },
        }
        local will_rename_method, did_rename_method = 'workspace/willRenameFiles', 'workspace/didRenameFiles'
        local clients = vim.lsp.get_clients()
        for _, client in ipairs(clients) do
            if client:supports_method(will_rename_method) then
                local res = client:request_sync(will_rename_method, changes, 1000, 0)
                if res and res.result then
                    vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding)
                end
            end
        end

        for _, client in ipairs(clients) do
            if client:supports_method(did_rename_method) then
                client:notify(did_rename_method, changes)
            end
        end
    end,
})
