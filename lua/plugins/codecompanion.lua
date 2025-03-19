-- nvim/lua/plugins/codecompanion.lua
return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        'echasnovski/mini.nvim',
    },
    opts = {
        log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO

        strategies = {
            chat = {
                adapter = "gemini",
                slash_commands = {
                    ["file"] = {
                        callback = "strategies.chat.slash_commands.file",
                        description = "Select a file using Telescope",
                        opts = {
                            provider = "telescope",
                            contains_code = true,
                        },
                    },
                    ["help"] = {
                        callback = "strategies.chat.slash_commands.help",
                        description = "Search help tags using Telescope",
                        opts = {
                            provider = "telescope",
                        },
                    },
                    ["symbols"] = {
                        callback = "strategies.chat.slash_commands.symbols",
                        description = "Search symbols using Telescope",
                        opts = {
                            provider = "telescope",
                        },
                    },
                },
            },
            inline = {
                adapter = "openai",
                keymaps = {
                    accept_change = {
                        modes = { n = "ga" },
                        description = "Accept the suggested change",
                    },
                    reject_change = {
                        modes = { n = "gr" },
                        description = "Reject the suggested change",
                    },
                },
            }
        },
        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key =
                        'cmd:hcp vault-secrets secrets open "claude" --app=cursor --format=json | jq -r ".static_version.value"',
                    },
                    model = "claude-3-5-sonnet-v2@20241022",
                })
            end,
            openai = function()
                return require("codecompanion.adapters").extend("openai", {
                    env = {
                        api_key =
                        'cmd:hcp vault-secrets secrets open "openai" --app=cursor --format=json | jq -r ".static_version.value"',
                    },
                    model = "chatgpt-4o-latest",
                })
            end,
            deepseek = function()
                return require("codecompanion.adapters").extend("deepseek", {
                    env = {
                        api_key =
                        'cmd:hcp vault-secrets secrets open "deepseek" --app=cursor --format=json | jq -r ".static_version.value"',

                    },
                    model = "deepseek-reasoner",
                })
            end,
            gemini = function()
                return require("codecompanion.adapters").extend("gemini", {
                    env = {
                        api_key =
                        'cmd:hcp vault-secrets secrets open "google" --app=cursor --format=json | jq -r ".static_version.value"',
                    },
                    model = "gemini-2.0-flash-001",
                })
            end,
            gemini = function()
                return require("codecompanion.adapters").extend("grok", {
                    env = {
                        api_key =
                        'cmd:hcp vault-secrets secrets open "grok" --app=cursor --format=json | jq -r ".static_version.value"',
                    },
                    model = "gork-3",
                })
            end,
            copilot = {
                -- No API Key needed, uses the copilot.lua plugin
            },
            openai_compatible = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "http[s]://open_compatible_ai_url",
                        api_key = "OpenAI_API_KEY",
                        chat_url = "/v1/chat/completions",
                    },
                })
            end,
        },
        prompts = {
            ["lsp_error_explain"] = {
                adapter = "openai",
            },
        },
        display = {
            action_palette = {
                width = 95,
                height = 10,
                prompt = "Prompt ",
                provider = "telescope",
                opts = {
                    show_default_actions = true,
                    show_default_prompt_library = true,
                },
            },
            chat = {
                window = {
                    layout = "float",
                    position = nil,
                    border = "single",
                    height = 0.8,
                    width = 0.8,
                    relative = "editor",
                    opts = {
                        breakindent = true,
                        cursorcolumn = false,
                        cursorline = false,
                        foldcolumn = "0",
                        linebreak = true,
                        list = false,
                        numberwidth = 1,
                        signcolumn = "no",
                        spell = false,
                        wrap = true,
                    },
                },
                token_count = function(tokens, adapter)
                    return " (" .. tokens .. " tokens)"
                end,
                diff = {
                    enabled = true,
                    close_chat_at = 240,
                    layout = "float",
                    opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                    provider = "mini_diff",
                },
                intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
                show_header_separator = false,
                separator = "─",
                show_references = true,
                show_settings = false,
                show_token_count = true,
                start_in_insert_mode = false,
            },
            inline = {
                layout = "float",
            },
        },
        opts = {
            log_level = "ERROR",
            language = "English",
            send_code = true,
            system_prompt = function(opts)
                return "My new system prompt"
            end,
        },
    },
}
