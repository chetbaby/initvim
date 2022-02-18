local actions = require("telescope.actions")
local custom_actions = {}
local telescope = require("telescope")

local noshow = { noremap = true, silent = true }
local show = { noremap = true, silent = false }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>fi", ":lua require('telescope.builtin').find_files({initial_mode = 'insert'})<CR>", noshow)
keymap("n", "<leader>ff", ":lua require('telescope.builtin').live_grep({initial_mode = 'insert'})<CR>", noshow)
keymap(
	"n",
	"<leader>ca",
	":lua require('telescope.builtin').lsp_code_actions({layout_strategy = 'cursor', layout_config = {width = 0.2, height = 0.2}})<CR>",
	noshow
)
keymap("n", "gr", ":lua require('telescope.builtin').lsp_references()<CR>", noshow)
keymap(
	"n",
	"<leader>dia",
	":lua require('telescope.builtin').diagnostics({layout_strategy = 'bottom_pane', layout_config = { height = 0.25 }, bufnr = 0})<CR>",
	noshow
)
keymap(
	"n",
	"<leader>die",
	":lua require('telescope.builtin').diagnostics({layout_strategy = 'bottom_pane', layout_config = { height = 0.25 }})<CR>",
	noshow
)
keymap("n", "<leader>ma", ":lua require('telescope.builtin').marks()<CR>", noshow)
keymap("n", "<leader>uf", ":lua require('telescope.builtin').buffers()<CR>", noshow)
keymap("n", "<leader>no", ":Telescope notify<CR>", noshow)
keymap("n", "<leader>pr", ":Telescope projects<CR>", noshow)
keymap("n", "<leader>sy", ":Telescope lsp_document_symbols<CR>", noshow)
keymap("n", "<leader>br", ":Telescope git_branches<CR>", noshow)
keymap("n", "<leader>com", ":Telescope git_commits<CR>", noshow)
keymap("n", "<leader>gcb", ":Telescope git_bcommits<CR>", noshow)
keymap("n", "<leader>co", ":Telescope colorscheme<CR>", noshow)
keymap("n", "<leader>ick", ":Telescope quickfix<CR>", show)

telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("notify")

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "%.jpg", "%.png" },
		vimgrep_arguments = {
			"rg",
			"--follow",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		mappings = {
			i = {
				-- Close on first esc instead of gonig to normal mode
				-- ["<esc>"] = actions.close,
				-- ["<A-q>"] = actions.end_selected_to_qflist, -- was giving error 🤬
				["<C-q>"] = actions.send_to_qflist,
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
				["<tab>"] = actions.toggle_selection + actions.move_selection_next,
				["<cr>"] = custom_actions.multi_selection_open,
				["<c-v>"] = custom_actions.multi_selection_open_vsplit,
				["<c-s>"] = custom_actions.multi_selection_open_split,
				["<c-t>"] = custom_actions.multi_selection_open_tab,
			},
			n = {
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
				["<tab>"] = actions.toggle_selection + actions.move_selection_next,
				["<C-Q>"] = actions.send_selected_to_qflist,
				["<C-q>"] = actions.send_to_qflist,
				["<cr>"] = custom_actions.multi_selection_open,
				["<c-v>"] = custom_actions.multi_selection_open_vsplit,
				["<c-s>"] = custom_actions.multi_selection_open_split,
				["<c-t>"] = custom_actions.multi_selection_open_tab,
			},
		},
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "normal",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				-- mirror = false,
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = { mirror = true },
			width = 0.87,
			height = 0.80,
			-- prompt_position = "bottom",
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	},
})
