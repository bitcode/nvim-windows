return {
    "nvimtools/none-ls.nvim",
    dependencies = { 'jose-elias-alvarez/null-ls.nvim' },
    priority = 1000,
    config = function()
        local null_ls = require("null-ls")
        local methods = null_ls.methods
        local sources = null_ls.builtins

        null_ls.setup({
            debug = false,
            sources = {
                sources.formatting.stylua.with({
                    filetypes = { "lua" },
                    method = methods.FORMATTING,
                    config = { --stylua config
                        -- add any stylua configuration here
                    },
                }),
                sources.code_actions.gitsigns.with({
                    config = {
                        filter_actions = function(title)
                            --filter out "blame" actions from gitsigns
                            return title:lower():match("blame") == nil
                        end,
                    },
                }),
                sources.code_actions.refactoring,
                sources.formatting.prettier.with({
                    filetypes = { "typescript", "cs", "csharp", "typescriptreact", "javascript", "javascriptreact", "html", "css", "scss", "less", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars", "svelte", "astro", "htmlangular" },
                    method = methods.FORMATTING,
                })
            },
        })
    end
}
