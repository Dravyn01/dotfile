require("lazy").setup({
	{
		"neovim/nvim-lspconfig", -- ไคลเอนต์ LSP หลักของ Neovim
		config = function()
			local lsp = require("config.lsp")

			lsp.setup_lua_ls()
			lsp.setup_ts_ls()
			lsp.setup_html()
			lsp.setup_cssls()
			lsp.setup_jsonls()
			lsp.setup_rust()
			lsp.setup_emmet_ls()
			lsp.setup_rust()
		end
	},

	{
		"williamboman/mason.nvim", -- ตัวจัดการ Language Servers/Formatters/Linters
		build = ":MasonUpdate", -- สั่งอัปเดตเมื่อติดตั้งหรืออัปเดต
		config = function()
			local ok, mason = pcall(require, "mason")
			if ok then
				mason.setup()
			else
				vim.notify("Error: Failed to load mason.nvim", vim.log.levels.ERROR)
			end
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim", -- เชื่อม Mason กับ nvim-lspconfig
		version = "1.29.0",
		dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
		event = "BufReadPre",
		opts = {
			ensure_installed = {
				"lua_ls", -- Lua Language Server
				"tsserver", -- TypeScript/JavaScript Language Server (formerly tsserver)
				"html", -- HTML Language Server
				"cssls", -- CSS Language Server
				"jsonls", -- JSON Language Server
				"eslint", -- ESLint Language Server (requires local ESLint setup)
				"rust_analyzer", -- Rust
				"emmet_ls" -- HTML
			},
		},
		config = function(_, opts)
			-- เรียก setup ของ mason-lspconfig โดยตรงด้วย opts
			local ok, mason_lspconfig_module = pcall(require, "mason-lspconfig")
			if ok then
				mason_lspconfig_module.setup({
					ensure_installed = opts.ensure_installed,
					-- *** ปิดการตั้งค่าอัตโนมัติ ***
					automatic_setup = false,
					-- automatic_installation = false,
					-- *** กำหนด handlers เป็นตารางว่างเปล่า ***
					-- เพื่อไม่ให้ Mason-LSPConfig พยายามตั้งค่า LSP client ใดๆ
					handlers = {},
				})
			else
				vim.notify("Error: Failed to load mason-lspconfig.nvim", vim.log.levels.ERROR)
			end
		end,
	},

	----------------------------------------------------------------------------
	-- Auto-completion (nvim-cmp)
	----------------------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp", -- Core completion plugin
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Source สำหรับ LSP
			"hrsh7th/cmp-buffer", -- Source สำหรับคำในบัฟเฟอร์ปัจจุบัน
			"hrsh7th/cmp-path", -- Source สำหรับเส้นทางไฟล์
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Source สำหรับ LuaSnip snippets
		},
		config = function()
			local ok, cmp_config = pcall(require, "config.cmp")
			if ok then
				cmp_config.setup()
			else
				vim.notify("Error: failed to load config.cmp", vim.log.levels.ERROR)
			end
		end
	},

	----------------------------------------------------------------------------
	-- Syntax Highlighting (nvim-treesitter)
	----------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- รันคำสั่งนี้เพื่ออัปเดต parsers หลังติดตั้ง
		config = function()
			local ok, ts_config = pcall(require, "config.treesitter")
			if ok then
				ts_config.setup() -- เรียกใช้ฟังก์ชันตั้งค่า Treesitter จากไฟล์แยก
			else
				vim.notify("Error: Failed to load config.treesitter", vim.log.levels.ERROR)
			end
		end,
	},

	----------------------------------------------------------------------------
	-- Code Formatting (conform.nvim)
	----------------------------------------------------------------------------
	{
		"stevearc/conform.nvim",
		config = function()
			local ok, conform_config = pcall(require, "config.conform")
			if ok then
				conform_config.setup() -- เรียกใช้ฟังก์ชันตั้งค่า Conform จากไฟล์แยก
			else
				vim.notify("Error: Failed to load config.conform", vim.log.levels.ERROR)
			end
		end,
	},

	----------------------------------------------------------------------------
	-- อื่นๆ ที่มีประโยชน์
	----------------------------------------------------------------------------
	{
		"folke/which-key.nvim", -- แสดงปุ่มลัดเมื่อกด leader key
		config = function()
			local ok, whichkey_config = pcall(require, "config.whichkey")
			if ok then
				whichkey_config.setup() -- เรียกใช้ฟังก์ชันตั้งค่า WhichKey จากไฟล์แยก
			else
				vim.notify("Error: Failed to load config.whichkey", vim.log.levels.ERROR)
			end
		end,
	},

	-- หากคุณต้องการเพิ่ม Icons ใน Neovim (ต้องใช้ Nerd Font)
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true, -- optional: disable by default, enable on demand
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- โหลดเมื่อเริ่มพิมพ์
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true, -- เช็ก syntax tree ก่อนใส่วงเล็บ
				fast_wrap = {},
			})

			-- ต่อกับ nvim-cmp (ถ้าใช้ cmp อยู่)
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},

	-- lua line
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-lualine/lualine.nvim' },
		config = function()
			local ok, lualine_config = pcall(require, "config.lualine")
			if ok then
				lualine_config.setup()
			else
				vim.notify("Error: failed to load config.lualine", vim.log.levels.ERROR)
			end
		end
	},

	{
		"ellisonleao/gruvbox.nvim",   -- ธีม Gruvbox
		priority = 1000,              -- โหลดก่อนปลั๊กอินอื่น ๆ ที่อาจใช้สี
		config = function()
			vim.cmd("colorscheme gruvbox") -- กำหนด colorscheme เป็น gruvbox
			vim.cmd("highlight Comment gui=italic") -- ทำให้ comment เป็นตัวเอียง (optional)
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",       -- แนะนำให้ใช้เวอร์ชันล่าสุด
		lazy = false,        -- ไม่ต้อง lazy load เพื่อให้เปิดพร้อม Neovim
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- ใช้ icons จากปลั๊กอินนี้
		},
		config = function()
			local ok, nvimtree_config = pcall(require, "config.nvimtree")
			if ok then
				nvimtree_config.setup()
			else
				vim.notify("Error: Failed to load config.nvimtree", vim.log.levels.ERROR)
			end
		end,
	},

	-- {
	--   "pmizio/typescript-tools.nvim",
	--   dependencies = { "nvim-lua/plenary.nvim" },
	--   ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	--   opts = {
	--     on_attach = function(client, bufnr)
	--       require("mason-lspconfig.on_attach")(client, bufnr)
	--     end,
	--     settings = {
	--       tsserver_file_preferences = {
	--         includeInlayParameterNameHints = "all",
	--         includeInVariableTypeHints = true,
	--         includeInlayFunctionLikeReturnTypeHints = true,
	--         includeInlayPropertyDeclarationTypeHints = true,
	--       },
	--       tsserver_format_options = {
	--         allowIncompleteCompletions = false,
	--         allowRenameOfImportPath = true,
	--       }
	--     }
	--   },
	-- },

	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		config = function()
			require("fidget").setup({})
		end,
	},

	-- {
	-- 	"p00f/nvim-ts-rainbow",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- ต้องใช้ treesitter
	-- 	event = "BufReadPost",                  -- โหลดเมื่ออ่านไฟล์เสร็จ
	-- 	config = function()
	-- 		require("nvim-treesitter.configs").setup({
	-- 			highlight = {
	-- 				enable = true
	-- 			},
	-- 			rainbow = {
	-- 				enable = true,
	-- 				extended_mode = true, -- ครอบคลุม [] และ {} เพิ่มเติม
	-- 				max_file_lines = nil, -- ไม่จำกัดจำนวนบรรทัด
	-- 			}
	-- 		})
	-- 	end
	-- },

	{
		"dstein64/nvim-scrollview",
		event = "BufReadPre",
		config = function()
			require("scrollview").setup({
				current_only = true,
				winblend = 100,
				base = 'right',
				column = 1,
				signs_on_startup = { 'all' },
				diagnostics_severities = { vim.diagnostic.severity.ERROR },
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { char = "│" }, -- ใช้เส้นตรงหรือ ▏ ก็ได้
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
					highlight = { "Function", "Label" },
				},
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical", -- หรือ horizontal
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					winblend = 10,
				},
			})
		end,
	},

	-- colorscheme
	{ "ntk148v/habamax.nvim", dependencies = { "rktjmp/lush.nvim" } },
})
