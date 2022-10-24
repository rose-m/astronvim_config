--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below
--

-- rosem: custom function for organizing typescript imports
local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local function save_buffer()
    if vim.bo.modified and vim.bo.filetype ~= "" and (vim.bo.buftype == nil or vim.bo.buftype == "") and
        vim.bo.modifiable then
        local view_state = vim.fn.winsaveview()
        vim.cmd("w")
        vim.fn.winrestview(view_state)
    end
end

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

    -- Configure AstroNvim updates
    updater = {
        remote = "origin", -- remote to use
        channel = "nightly", -- "stable" or "nightly"
        version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "main", -- branch name (NIGHTLY ONLY)
        commit = nil, -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false, -- skip prompts about breaking changes
        show_changelog = true, -- show the changelog after performing an update
        auto_reload = false, -- automatically reload and sync packer after a successful update
        auto_quit = false, -- automatically quit the current session after a successful update
        -- remotes = { -- easily add new remotes to track
        --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
        --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
        --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        -- },
    },

    -- Set colorscheme to use
    colorscheme = "tundra",

    -- Add highlight groups in any theme
    highlights = {
        -- duskfox = { -- a table of overrides
        --   Normal = { bg = "#000000" },
        -- },
        default_theme = function(highlights) -- or a function that returns one
            local C = require "default_theme.colors"

            highlights.Normal = { fg = C.fg, bg = C.bg }
            return highlights
        end,
    },

    default_theme = {
        diagnostics_style = { italic = true },
        -- Modify the color table
        colors = {
            fg = "#abb2bf",
        },
        plugins = { -- enable or disable extra plugin highlighting
            aerial = true,
            beacon = false,
            bufferline = true,
            dashboard = true,
            highlighturl = true,
            hop = false,
            indent_blankline = true,
            lightspeed = false,
            ["neo-tree"] = true,
            notify = true,
            ["nvim-tree"] = false,
            ["nvim-web-devicons"] = true,
            rainbow = true,
            symbols_outline = false,
            telescope = true,
            vimwiki = false,
            ["which-key"] = true,
        },
    },

    -- Disable AstroNvim ui features
    ui = {
        nui_input = true,
        telescope_select = true,
    },

    -- set vim options here (vim.<first_key>.<second_key> =  value)
    options = {
        opt = {
            -- set to true or false etc.
            relativenumber = true, -- sets vim.opt.relativenumber
            number = true, -- sets vim.opt.number
            spell = false, -- sets vim.opt.spell
            signcolumn = "auto", -- sets vim.opt.signcolumn to auto
            wrap = false, -- sets vim.opt.wrap
            title = true,
            guifont = "JetBrainsMono Nerd Font Mono:h13",
            background = "dark",
            tabstop = 4,
            shiftwidth = 0,
            autoread = true,
        },
        g = {
            mapleader = " ", -- sets vim.g.mapleader
            autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
            cmp_enabled = true, -- enable completion at start
            autopairs_enabled = true, -- enable autopairs at start
            diagnostics_enabled = true, -- enable diagnostics at start
            status_diagnostics_enabled = true, -- enable diagnostics in statusline
            icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        },
    },
    -- If you need more control, you can use the function()...end notation
    -- options = function(local_vim)
    --   local_vim.opt.relativenumber = true
    --   local_vim.g.mapleader = " "
    --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
    --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
    --
    --   return local_vim
    -- end,

    -- Extend LSP configuration
    lsp = {
        -- enable servers that you already have installed without mason
        servers = {
            -- "pyright"
        },
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true, -- enable or disable format on save globally
                disable_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                    -- "typescript",
                    -- "typescriptreact",
                    -- "ts",
                    -- "tsx",
                },
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                "tsserver",
            },
            timeout_ms = 1000, -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- easily add or disable built in mappings added during LSP attaching
        mappings = {
            n = {
                -- ["<leader>lf"] = false -- disable formatting keymap
            },
        },
        -- add to the global LSP on_attach function
        -- on_attach = function(client, bufnr)
        -- end,

        -- override the mason server-registration function
        -- server_registration = function(server, opts)
        --   require("lspconfig")[server].setup(opts)
        -- end,

        -- Add overrides for LSP server settings, the keys are the name of the server
        ["server-settings"] = {
            -- example for addings schemas to yamlls
            -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
            --   settings = {
            --     yaml = {
            --       schemas = {
            --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
            --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            --       },
            --     },
            --   },
            -- },
        },
    },

    -- Mapping data with "desc" stored directly by vim.keymap.set().
    --
    -- Please use this mappings table to set keyboard mapping since this is the
    -- lower level configuration and more robust one. (which-key will
    -- automatically pick-up stored data by this setting.)
    mappings = {
        -- first key is the mode
        n = {
            -- second key is the lefthand side of the map
            -- mappings seen under group name "Buffer"
            ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
            ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
            ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
            ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
            ['<leader>bC'] = {
                function()
                    local view_state = vim.fn.winsaveview()
                    vim.cmd("%bd|e#|bd#")
                    vim.cmd("Neotree toggle")
                    vim.cmd("wincmd l")
                    vim.fn.winrestview(view_state)
                end,
                desc = "Close all other buffers"
            },
            ["<leader>lo"] = { "<cmd>SymbolsOutline<cr>", desc = "Open symbols outline" },
            ['<c-cr>'] = { function() vim.lsp.buf.code_action() end, desc = "Open Actions" },
            ['<c-ä>'] = { organize_imports, desc = "Organize Imports" },

            -- quick save
            -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
            -- setting a mapping to false will disable it
            -- ["<esc>"] = false,
        },
        i = {
            ['<c-k>'] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>" }
            -- ["<c-e>"] = { "<esc>:b#<cr>a", desc = "Go to previous tab" },
        },
    },

    -- Configure plugins
    plugins = {
        init = {
            -- You can disable default plugins as follows:
            -- ["goolord/alpha-nvim"] = { disable = true },

            -- You can also add new plugins here as well:
            -- Add plugins, the packer syntax without the "use"
            -- { "andweeb/presence.nvim" },
            -- {
            --   "ray-x/lsp_signature.nvim",
            --   event = "BufRead",
            --   config = function()
            --     require("lsp_signature").setup()
            --   end,
            -- },

            -- We also support a key value style plugin definition similar to NvChad:
            -- ["ray-x/lsp_signature.nvim"] = {
            --   event = "BufRead",
            --   config = function()
            --     require("lsp_signature").setup()
            --   end,
            -- },
            { 'sam4llis/nvim-tundra',
                config = function()
                    local cp = require('nvim-tundra.palette.arctic')
                    require('nvim-tundra').setup({
                        transparent_background = false,
                        editor = {
                            search = {},
                            substitute = {},
                        },
                        syntax = {
                            booleans = { bold = true, italic = true },
                            comments = { bold = true, italic = true },
                            conditionals = {},
                            constants = { bold = true },
                            functions = {},
                            keywords = {},
                            loops = {},
                            numbers = { bold = true },
                            operators = { bold = true },
                            punctuation = {},
                            strings = {},
                            types = { italic = true },
                        },
                        diagnostics = {
                            errors = { fg = cp.red._700 },
                            warnings = { fg = cp.orange_500 },
                            information = {},
                            hints = { fg = cp.orange_500 },
                        },
                        plugins = {
                            lsp = true,
                            treesitter = true,
                            context = true,
                            gitsigns = true,
                            telescope = true,
                        },
                        overwrite = {
                            colors = {},
                            highlights = {},
                        },
                    })
                end,
            },
            { 'fatih/vim-go' },
            { 'simrat39/symbols-outline.nvim' }
        },
        ["neo-tree"] = {
            window = {
                width = 70
            }
        },
        telescope = {
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                },
                preview = {
                    treesitter = false
                }
            },
        },
    },

    -- LuaSnip Options
    luasnip = {
        -- Add paths for including more VS Code style snippets in luasnip
        vscode_snippet_paths = {
            "./lua/user/snippets"
        },
        -- Extend filetypes
        filetype_extend = {
            -- javascript = { "javascriptreact" },
        },
    },

    -- CMP Source Priorities
    -- modify here the priorities of default cmp sources
    -- higher value == higher priority
    -- The value can also be set to a boolean for disabling default sources:
    -- false == disabled
    -- true == 1000
    cmp = {
        source_priority = {
            nvim_lsp = 1000,
            luasnip = 750,
            buffer = 500,
            path = 250,
        },
    },

    -- Modify which-key registration (Use this with mappings table in the above.)
    ["which-key"] = {
        -- Add bindings which show up as group name
        register = {
            -- first key is the mode, n == normal mode
            n = {
                -- second key is the prefix, <leader> prefixes
                ["<leader>"] = {
                    -- third key is the key to bring up next level and its displayed
                    -- group name in which-key top level menu
                    ["b"] = { name = "Buffer" },
                },
            },
        },
    },

    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
        -- somehow need to call this manually here
        require("symbols-outline").setup({
            width = 40,
            auto_close = 1,
            autofold_depth = 1,
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" or
                    vim.bo.filetype == "javascriptreact" or
                    vim.bo.filetype == "typescriptreact"
                then
                    -- NOTE: don't format javascript files
                    vim.cmd("EslintFixAll")
                    -- vim.lsp.buf.format({ name = "eslint" }) -- works too
                    return
                elseif vim.bo.filetype == "proto" then
                    local view_state = vim.fn.winsaveview()
                    vim.cmd("%!clang-format --assume-filename=%")
                    vim.fn.winrestview(view_state)
                end
            end,
        })

        vim.api.nvim_create_autocmd("BufLeave", {
            pattern = "*",
            callback = save_buffer
        })
    end,
}

return config
