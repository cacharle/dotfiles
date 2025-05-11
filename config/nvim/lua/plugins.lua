local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }
    local map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    map("n", "<leader>[", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    map("n", "<leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    map("n", "<leader>q", "<cmd>Telescope diagnostics<CR>", opts)
    map("n", "<leader>p", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
    map("n", "<leader>r", "<cmd>Telescope lsp_references<CR>", opts)
end

local telescope_fzf_native_build = ""
local sysname = vim.uv.os_uname().sysname
if sysname == "Linux" then
    telescope_fzf_native_build = "make"
else
    telescope_fzf_native_build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
end

return {
    -- Move arguments sideways
    {
        "AndrewRadev/sideways.vim",
        keys = { "<leader>l", "<leader>h" },
        config = function ()
            vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>SidewaysRight<cr>", {})
            vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>SidewaysLeft<cr>", {})
        end
    },

    -- only highlight search matches when searching
    {
        "romainl/vim-cool",
        keys = {"/", "*", "#", ":%"},
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "▏",
            },
            scope = {
                char = "▎",
                show_start = false,
                show_end = false,
            },
        },
    },

    -- basic commands on current file (Rename/Remove)
    {
        "tpope/vim-eunuch",
        cmd = { "Rename", "Remove", "Copy", "Mkdir", "Chmod" }
    },

    {
        "ellisonleao/glow.nvim",
        ft = "markdown",
        config = function() require("glow").setup() end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            window = {
                mappings = {
                    ["<c-x>"] = "open_split",
                    ["<c-v>"] = "open_vsplit",}
            },
        },
    },

    {
        "lewis6991/satellite.nvim",
        enabled = false,
        opts = {
            handlers = { gitsigns = { enable = false } },
        },
    },

    {
        "andymass/vim-matchup",
        enabled = false,
        setup = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },

    -- Put arguments on multiple lines
    {
        "FooSoft/vim-argwrap",
        keys = { "<leader>w" },
        config = function()
            local augroup = vim.api.nvim_create_augroup("cacharle_vim_argwrap_group", {})
            vim.g.argwrap_tail_comma = 1
            vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>ArgWrap<cr>", {})
            vim.api.nvim_create_autocmd(
                "Filetype",
                {
                    pattern = "c,cpp",
                    callback = function() vim.g.argwrap_tail_comma = 0 end,
                    group = augroup,
                }
            )
            vim.api.nvim_create_autocmd(
                "Filetype",
                {
                    pattern = "go,lua",
                    callback = function() vim.g.argwrap_padded_braces = "{" end,
                    group = augroup,
                }
            )
        end
    },

    {
        "jpalardy/vim-slime",
        keys = { "<C-c><C-c>", "<C-c>v" },
        config = function() vim.g.slime_target = "tmux" end
    },

    {
        "cacharle/vim-jinja-languages",
        ft = "jinja",
        dependencies = {"mitsuhiko/vim-jinja"}
    },

    -- python formatter
    {
        "psf/black",
        branch = "stable",
        ft = "python",
        config = function()
            vim.g.black_linelength = 100
            -- local augroup = vim.api.nvim_create_augroup("cacharle_black_group", {})
            -- vim.api.nvim_create_autocmd(
            --     "BufWritePre",
            --     { command = "silent Black", pattern = "*.py", group = augroup }
            -- )
        end
    },

    -- nvim lsp configuration
    {
        "neovim/nvim-lspconfig",
        ft = {"python", "c", "cpp", "lua", "go", "haskell", "ocaml", "zig", "yaml", "odin"},
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function ()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            mason.setup()
            mason_lspconfig.setup {
                ensure_installed = {
                    "gopls",
                    "pylsp",
                    "lua_ls",
                    "clangd",
                    "zls",
                    "yamlls",
                    "ols",
                    -- "haskell-language-server",
                    -- "ocamllsp",
                },
            }
            local lspconfig = require("lspconfig")
            vim.diagnostic.config { signs = false, update_in_insert = false }
            local capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )
            -- $ go install golang.org/x/tools/gopls
            lspconfig.gopls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = { unusedparams = true },
                        staticcheck = true
                    }
                }
            }
            -- from: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
            local go_import_callback = function()
                local wait_ms = 1000
                local params = vim.lsp.util.make_range_params()
                params.context = {only = {"source.organizeImports"}}
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
                for _, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
                        else
                            vim.lsp.buf.execute_command(r.command)
                        end
                    end
                end
            end
            local augroup = vim.api.nvim_create_augroup("cacharle_gopls_group", {})
            vim.api.nvim_create_autocmd(
                "BufWritePre",
                { callback = go_import_callback, pattern = "*.go", group = augroup }
            )
            -- lspconfig.rust_analyzer.setup { on_attach = on_attach }
            -- need python-lsp-server and pyls-flake8
            lspconfig.pylsp.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            flake8 = {
                                ignore = {"E501", "E221", "W503", "E241", "E402"},
                                maxLineLength = 100,
                            },
                        },
                    },
                },
            }
            -- package lua-language-server on ArchLinux
            lspconfig.lua_ls.setup {
                on_attach = on_attach ,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                            -- Setup your lua path
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {"vim", "use"},
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            },
                        },
                    }
                },
            }
            -- brew install haskell-language-server
            lspconfig.hls.setup { on_attach = on_attach }
            -- opam install ocaml-lsp-server
            lspconfig.ocamllsp.setup { on_attach = on_attach }
            -- NOTE: to add compile arguments for standalone mode, create a .clangd file
            lspconfig.clangd.setup { on_attach = on_attach, cmd = {
                "clangd",
                "--header-insertion=never",
                "--pch-storage=memory",
                -- TODO: "--clang-tidy",
            } }
            -- pacman -S zls
            lspconfig.zls.setup{}
            -- pacman -S yaml-language-server
            lspconfig.yamlls.setup {
                settings = {
                    yaml = {
                        -- schemas = {
                        --     ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.17.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                        -- }
                        schemas = {
                            kubernetes = "*.yaml",
                            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                            ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                            ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                            ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                            ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                            -- ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
                            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                            ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
                        },
                    }
                }
            }
            lspconfig.ols.setup{ on_attach = on_attach }
        end,
    },

    {
        "mrcjkb/rustaceanvim",
        ft = {"rust"},
        config = function()
            -- require("rustaceanvim")
            -- to toggle inlay hints
            -- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            vim.diagnostic.config { signs = false, update_in_insert = false }
            vim.g.rustfmt_autosave_if_config_present = 1
            -- vim.g.rustaceanvim.server.on_attach = function(_, bufnr)
            --     local opts = { noremap = true, silent = true }
            --     local map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            --     map("n", "<leader>me", "<cmd>RustLsp expandMacro<CR>", opts)
            --     map("n", "<leader>d", "<cmd>RustLsp renderDiagnostic<CR>", opts)
            -- end
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "onsails/lspkind.nvim",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local lspkind = require("lspkind")
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup {
                mapping = cmp.mapping.preset.insert({
                    -- ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        local has_words_before = function()
                          unpack = unpack or table.unpack
                          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                        end
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                -- order of the sources matter (first are higher priority)
                sources = {
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                    { name = "buffer", keyword_length = 2 },
                },
                formatting = {
                    format = lspkind.cmp_format({
                        with_text = true,
                        menu = {
                            nvim_lsp = "[LSP]",
                            path = "[path]",
                            buffer = "[buf]",
                        }
                    })
                },
                window = { documentation = cmp.config.window.bordered(), },
                experimental = { ghost_text = true, },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                }
            }
        end
    },

    {
        'mfussenegger/nvim-dap',
        keys = { "<F5>", "<leader>b", "<leader>gb" },
        dependencies = {
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            -- "nvim-telescope/telescope-dap.nvim",
            -- "mfussenegger/nvim-dap-python",
        },
        config = function ()
            require("mason").setup()
            require("mason-nvim-dap").setup {
                ensure_installed = { "codelldb" },
                handlers = {},
            }
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup({
                controls = {
                    icons = {
                        terminate = "T",
                    }
                }
            })
            require("nvim-dap-virtual-text").setup()
            vim.keymap.set("n", "<F4>", dap.terminate)
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F6>", dap.restart)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>db", dap.clear_breakpoints)
            --TODO: set_exception_breakpoints()
            vim.keymap.set("n", "<leader>gb", function()
                if dap.session() then
                    dap.run_to_cursor()
                else
                    dap.set_breakpoint()
                    dap.continue()
                end
            end)
            vim.keymap.set("n", "<leader>dr", dap.repl.open)
            vim.keymap.set("n", "<leader>?", function() dapui.eval(nil, { enter = true }) end)
            -- The gdb adapter doesn't fully work (only able to use 1 breakpoint)
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = {"--interpreter", "dap", "--eval-command", "set print pretty on"},
            }
            local sysname = vim.uv.os_uname().sysname
            local codelldb_command = ""
            if sysname == "Linux" then
                -- Install: yay -S codelldb-bin
                codelldb_command = "codelldb"
            else
                codelldb_command = "C:\\Users\\charl\\.vscode\\extensions\\vadimcn.vscode-lldb-1.11.4\\adapter\\codelldb.exe"
            end
            dap.adapters.codelldb = {
                type = "executable",
                command = codelldb_command,
                detached = false,
            }
            local c_cpp_config = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    setupCommands = {
                      {
                         text = '-enable-pretty-printing',
                         description =  'enable pretty printing',
                         ignoreFailures = false
                      },
                    },
                },
            }
            dap.configurations.c = c_cpp_config
            dap.configurations.cpp = c_cpp_config
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
        end
    },

    -- gruvbox color scheme
    {
        "ellisonleao/gruvbox.nvim",
        dependencies = {"rktjmp/lush.nvim"},
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd [[ colorscheme gruvbox ]]
            vim.g.gruvbox_italic = 1
            vim.g.gruvbox_bold = 1
            vim.g.gruvbox_termcolors = 256
            vim.g.gruvbox_contrast_dark = "medium"
            vim.g.gruvbox_contrast_light = "hard"
            vim.g.gruvbox_invert_selection = 0
        end
    },

    -- nord color scheme
    {
        "shaunsingh/nord.nvim",
        enabled = false,
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd [[ colorscheme nord ]]
            vim.g.nord_contrast = true
            vim.g.nord_borders = true
            vim.g.nord_italic = true
        end
    },

    -- tokyonight color scheme
    {
        "folke/tokyonight.nvim",
        enabled = false,
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd [[ colorscheme tokyonight-moon ]]
            require("tokyonight").setup({
              styles = {
                comments = { italic = true },
                keywords = { italic = true },
              },
            })
        end
    },

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"kyazdani42/nvim-web-devicons"},
        opts =  {
            options = {
                -- theme = "tokyonight",
                theme = "gruvbox",
                -- theme = "nord",
                icons_enabled = true,
                section_separators = '',
                component_separators = '',
            },
            sections = {
                lualine_a = { { "mode", fmt = function (s) return s:sub(1, 1) end } },
                -- path=1 for Relative path (https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#filename-component-options)
                lualine_c = { { "filename", path = 1 } },
            },
        },
    },

    -- better syntax highlight for everything
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "bash",
                    "c",
                    "commonlisp",
                    "cpp",
                    "cuda",
                    "fish",
                    "glsl",
                    "go",
                    "haskell",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "mermaid",
                    "meson",
                    "odin",
                    "python",
                    "query",
                    "rust",
                    "toml",
                    "vim",
                    "vimdoc",
                    "yaml",
                    "zig",
                },
                highlight = { enable = true },
                matchup = {
                    enable = true,              -- mandatory, false will disable the whole extension
                    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
                    -- [options]
                },
                -- indent = { enable = true },
                -- TODO: could be neat
                -- incremental_selection = {
                --     enable = true,
                --     keymaps = {
                --         init_selection = "gnn",
                --         node_incremental = "grn",
                --         scope_incremental = "grc",
                --         node_decremental = "grm",
                --     }
                -- }
            }
            vim.cmd [[ highlight link pythonTSKeywordOperator Keyword ]]
        end
    },

    -- fuzzy finder (replace fzf.vim or ctrlp.vim)
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            "<C-p>",
            "<leader>;",
            "<leader>gg>",
            "<leader>G",
            "<leader>H",
            "<leader>q",
            "<leader>p",
        },
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"kyazdani42/nvim-web-devicons"},
            {"nvim-telescope/telescope-symbols.nvim"},
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = telescope_fzf_native_build,
                config = function() require("telescope").load_extension("fzf") end
            },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-u>"] = actions.delete_buffer,
                            ["<esc>"] = actions.close,
                            ["kj"] = actions.close,
                        }
                    },
                },
            }
            local map = vim.api.nvim_set_keymap
            map('n', '<C-p>', '<CMD>lua require"telescope-config".project_files()<CR>', { noremap = true, silent = true })
            map("n", "<leader>H", "<cmd>Telescope help_tags<cr>", {})
            map("n", "<leader>;", "<cmd>Telescope commands<cr>", {})
            -- map("n", "<leader>p", "<cmd>Telescope tags<cr>", {})
            map("n", "<leader>gg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
            map("n", "<leader>G", "<cmd>Telescope grep_string<cr>", {})
        end
    },

    -- todos,fix,etc.. highlight and list
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            signs = false,
            -- Add a space after the ':' since I use the quickfix library at work which has the FIX:: namespace
            highlight = { pattern = [[.*<(KEYWORDS)\s*: ]] },
            search = { pattern = [[\b(KEYWORDS): ]] },
        },
    },


    {
        "lewis6991/gitsigns.nvim",
        -- version = 'release',
        opts = {
            signcolumn = false,
            numhl = true,
            on_attach = function(bufnr)
                local opts = { silent = true, noremap = true, expr = true }
                -- local map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                local function map(mode, l, r)
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                local gs = package.loaded.gitsigns
                map(
                    "n",
                    "]c",
                    function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end
                )
                map(
                    "n",
                    "[c",
                    function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end
                )
                map(
                    "n",
                    "<leader>ga",
                    function()
                        vim.schedule(function() gs.stage_hunk() end)
                        return "<Ignore>"
                    end
                )
                map(
                    "n",
                    "<leader>gd",
                    function()
                        vim.schedule(function() gs.undo_stage_hunk() end)
                        return "<Ignore>"
                    end
                )
            end
        }
    },

    {
        "RaafatTurki/hex.nvim",
        opts = {}
    },

    {
       "goolord/alpha-nvim",
       dependencies = { 'nvim-tree/nvim-web-devicons' },
       config = function()
           local startify = require("alpha.themes.startify")
           startify.file_icons.provider = "devicons"
           require("alpha").setup(startify.config)
       end,
    },

    -- remote files and lsp
    {
        'chipsenkbeil/distant.nvim',
        enabled = false,
        branch = 'v0.3',
        build = ":DistantInstall",
        config = function()
            require('distant'):setup()
            require("telescope").load_extension("distant")
            require("distant").setup {
                ["*"] = require("distant.settings").chip_default()
            }
            -- TODO: extend with job_distant_config.lua
        end,
    },

    -- jupyter kernel in nvim (with images, needs ueberzug)
    {
        "benlubas/molten-nvim",
        enabled = false,
        ft = { "python" }, -- doesn"t work
        build = ":UpdateRemotePlugins",
        dependencies = {
            "3rd/image.nvim",
            config = function()
                require("image").setup({
                    backend = "ueberzug",
                    processor = "magick_cli",
                    max_width = 300, -- tweak to preference
                    max_height = 35, -- ^
                    max_height_window_percentage = math.huge, -- this is necessary for a good experience
                    max_width_window_percentage = math.huge,
                    window_overlap_clear_enabled = true,
                    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                })
            end
        },
        version = "^1.0.0",
        config = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 35
            -- local map = vim.api.nvim_set_keymap
            vim.keymap.set("n", "<leader>m",  "nvim_exec('MoltenEvaluateOperator', v:true)", { expr = true})
            vim.keymap.set("n", "<leader>mm", "<cmd>MoltenEvaluateLine<CR>", {})
            vim.keymap.set("v", "<leader>m",  ":<C-u>MoltenEvaluateVisual<CR>gv", {})
            vim.keymap.set("n", "<leader>mc", "<cmd>MoltenReevaluateCell<CR>", {})
            vim.keymap.set("n", "<leader>md", "<cmd>MoltenDelete<CR>", {})
            vim.keymap.set("n", "<leader>mo", "<cmd>MoltenShowOutput<CR>", {})
        end
    },

    {'akinsho/git-conflict.nvim', config = true},

    -- {
    --     'cameron-wags/rainbow_csv.nvim',
    --     config = true,
    --     ft = {
    --         'csv',
    --         'tsv',
    --         'csv_semicolon',
    --         'csv_whitespace',
    --         'csv_pipe',
    --         'rfc_csv',
    --         'rfc_semicolon'
    --     },
    --     cmd = {
    --         'RainbowDelim',
    --         'RainbowDelimSimple',
    --         'RainbowDelimQuoted',
    --         'RainbowMultiDelim'
    --     }
    -- }

    -- { "~/git/argwrap.nvim", opt = true },
}
