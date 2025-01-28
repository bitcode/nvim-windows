return {
    "OmniSharp/omnisharp-vim",
    name = "omnisharp-vim",
    priority = 1000,
    config = function()
        -- Enable the stdio version of OmniSharp-roslyn (recommended)
        vim.g.OmniSharp_server_stdio = 1

        -- Automatically start the server for .cs files
        vim.g.OmniSharp_start_server = 1

        -- Use .NET 6.0 version of OmniSharp-roslyn
        vim.g.OmniSharp_server_use_net6 = 1

        -- Enable snippet completion (optional)
        vim.g.OmniSharp_want_snippet = 1

        -- Enable automatic semantic highlighting
        vim.g.OmniSharp_highlighting = 2

        -- Set up key mappings (optional)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', 'gd', ':OmniSharpGotoDefinition<CR>', opts)
        vim.api.nvim_set_keymap('n', 'gi', ':OmniSharpFindImplementations<CR>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>ca', ':OmniSharpGetCodeActions<CR>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>rn', ':OmniSharpRename<CR>', opts)
    end,
}
