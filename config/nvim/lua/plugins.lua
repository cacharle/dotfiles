vim.cmd [[ packadd packer.nvim ]]

return require("packer").startup(function()
    use "wbthomason/packer.nvim"    -- plugin manager (can manage itself)
    use "junegunn/vim-easy-align"   -- align
    use "AndrewRadev/sideways.vim"  -- Move arguments sideways
    use "tpope/vim-eunuch"          -- basic commands on current file (Rename/Remove)
    use "romainl/vim-cool"          -- only highlight search matches when searching
    use "lukas-reineke/indent-blankline.nvim"

    -- Put arguments on multiple lines
    use {
        "FooSoft/vim-argwrap",
        config = function()
            vim.g.argwrap_tail_comma = 1
        end
    }

    use {
        "jpalardy/vim-slime",
        config = function()
            vim.g.slime_target = "tmux"
        end
    }

    use {
        "cacharle/vim-jinja-languages",
        requires = {"mitsuhiko/vim-jinja"}
    }

    -- python formatter
    use {
        "psf/black",
        tag = "stable",
        ft = "python",
        config = function()
            local augroup = vim.api.nvim_create_augroup("cacharle_black_group", {})
            vim.api.nvim_create_autocmd(
                "BufWritePre",
                { command = "Black", pattern = "*.py", group = augroup }
            )
        end
    }

    -- tags managment
    use {
        "ludovicchabant/vim-gutentags",
        config = function()
            vim.g.gutentags_ctags_exclude = {
                "doc/*",
                "docs/*",
                "Makefile",
                ".mypy_cache",
                ".pytest_cache",
                ".tox",
                "build/*",
                "dist/*"
            }
        end
    }


    -- nvim lsp configuration
    use {
        "neovim/nvim-lspconfig",
        ft = {"rust", "python", "c", "cpp", "lua", "go"},
        config = function()
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
                map("n", "<leader>q", "<cmd>Telescope diagnostics<CR>", opts)
                map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            end
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").update_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )

            -- $ go install golang.org/x/tools/gopls
            lspconfig.gopls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true
                        },
                        staticcheck = true
                    }
                }
            }
            -- from: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
            function go_import_callback()
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

            -- lspconfig.clangd.setup { on_attach = on_attach }
            -- lspconfig.rust_analyzer.setup { on_attach = on_attach }
            -- need python-lsp-server and pyls-flake8
            lspconfig.pylsp.setup { on_attach = on_attach, capabilities = capabilities }

            -- package lua-language-server on ArchLinux
            -- lspconfig.sumneko_lua.setup {
            --     on_attach = on_attach ,
            --     settings = {
            --         Lua = {
            --             runtime = {
            --                 -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
            --                 version = "LuaJIT",
            --                 -- Setup your lua path
            --                 path = vim.split(package.path, ";"),
            --             },
            --             diagnostics = {
            --                 -- Get the language server to recognize the `vim` global
            --                 globals = {"vim"},
            --             },
            --             workspace = {
            --                 -- Make the server aware of Neovim runtime files
            --                 library = {
            --                     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            --                     [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            --                 },
            --             },
            --         }
            --     },
            -- }
            vim.diagnostic.config {
                signs = false,
                update_in_insert = false,
            }
        end,
    }

    -- -- rust lsp (needs rust-analyser)
    -- use {
    --     "simrat39/rust-tools.nvim",
    --     requires = {"neovim/nvim-lspconfig"},
    --     ft = {"rust"},
    --     config = function()
    --         local on_attach = function(_, bufnr)
    --             local opts = { noremap = true, silent = true }
    --             local map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    --             map("n", "<leader>[", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    --             map("n", "<leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    --             map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    --             map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    --             map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    --             map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    --             map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    --             map("n", "<leader>q", "<cmd>Telescope diagnostics<CR>", opts)
    --             map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    --         end
    --         require("rust-tools").setup {
    --             server = {
    --                 on_attach = on_attach,
    --             }
    --         }
    --         vim.diagnostic.config {
    --             signs = false,
    --             update_in_insert = false,
    --         }
    --     end
    -- }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
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
                window = {
                    documentation = cmp.config.window.bordered(),
                },
                experimental = {
                    ghost_text = true,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                }
            }
        end
    }


    -- comment text objects
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }
    -- gruvbox color scheme
    -- use {
    --     "ellisonleao/gruvbox.nvim",
    --     requires = {"rktjmp/lush.nvim"},
    --     config = function()
    --         vim.opt.termguicolors = true
    --         vim.opt.background = "dark"
    --         -- vim.cmd [[ colorscheme gruvbox ]]
    --         vim.g.gruvbox_italic = 1
    --         vim.g.gruvbox_bold = 1
    --         vim.g.gruvbox_termcolors = 256
    --         vim.g.gruvbox_contrast_dark = "medium"
    --         vim.g.gruvbox_contrast_light = "hard"
    --         vim.g.gruvbox_invert_selection = 0
    --     end
    -- }
    -- nord color scheme
    use {
        "shaunsingh/nord.nvim",
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd [[ colorscheme nord ]]
            vim.g.nord_contrast = true
            vim.g.nord_borders = true
            vim.g.nord_italic = true
        end
    }
    -- status line
    use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
            require("lualine").setup {
                options = {
                    -- theme = "gruvbox",
                    theme = "nord",
                    icons_enabled = true,
                    section_separators = "",
                    component_separators = "",
                    -- globalstatus = true,
                }
            }
        end
    }
    -- better syntax highlight for everything
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                highlight = {
                    enable = true
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
    }
    -- fuzzy finder (replace fzf.vim or ctrlp.vim)
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"kyazdani42/nvim-web-devicons", opt = true},
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
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
                            ["<esc>"] = actions.close,
                            ["kj"] = actions.close,
                        }
                    },
                },
            }
            local map = vim.api.nvim_set_keymap
            map("n", "<C-p>", "<cmd>Telescope git_files<cr>", {})
            map("n", "<leader>H", "<cmd>Telescope help_tags<cr>", {})
            map("n", "<leader>;", "<cmd>Telescope commands<cr>", {})
            map("n", "<leader>p", "<cmd>Telescope tags<cr>", {})
            map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", {})
            map("n", "<leader>G", "<cmd>Telescope grep_string<cr>", {})
        end

    }
    -- todos,fix,etc.. highlight and list
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                signs = false
            }
        end
    }

    -- remote files and lsp
    use {
        "chipsenkbeil/distant.nvim",
        config = function()
            -- local on_attach = function(client, bufnr)
            --     local opts = { noremap = true, silent = true }
            --     local map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            --     map("n", "<leader>[", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            --     map("n", "<leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            --     map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            --     map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
            --     map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
            --     map("n", "<leader>q", "<cmd>Telescope lsp_workspace_diagnostics<CR>", opts)
            --     map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            -- end
            require("distant").setup {
                ["*"] = require("distant.settings").chip_default()
            }
            -- TODO: extend with job_distant_config.lua
        end,
        run = ":DistantInstall"
    }

    -- jupyter kernel in nvim (with images, needs ueberzug)
    use {
        "dccsillag/magma-nvim",
        -- ft = { "python" }, -- doesn"t work
        run = ":UpdateRemotePlugins",
        config = function()
            local map = vim.api.nvim_set_keymap
            map("n", "<leader>m",  "nvim_exec('MagmaEvaluateOperator', v:true)", { expr = true})
            map("n", "<leader>mm", "<cmd>MagmaEvaluateLine<CR>", {})
            map("x", "<leader>m",  "<cmd><C-u>MagmaEvaluateVisual<CR>", {})
            map("n", "<leader>mc", "<cmd>MagmaReevaluateCell<CR>", {})
            map("n", "<leader>md", "<cmd>MagmaDelete<CR>", {})
            map("n", "<leader>mo", "<cmd>MagmaShowOutput<CR>", {})
        end
    }

    use { "nvim-treesitter/playground", opt = true, cmd = { "TSPlaygroundToggle" } }
    -- use { "~/git/argwrap.nvim", opt = true }
end)
