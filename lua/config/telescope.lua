local actions = require("telescope.actions")
local custom_actions = {}
local telescope = require("telescope")

telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("zoxide")
telescope.load_extension("heading")
telescope.load_extension("file_browser")
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
				["<esc>"] = actions.close,
				-- ["<A-q>"] = actions.end_selected_to_qflist, -- was giving error 🤬
				["<C-q>"] = actions.send_to_qflist,
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
				["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
				["<cr>"] = custom_actions.multi_selection_open,
				["<c-v>"] = custom_actions.multi_selection_open_vsplit,
				["<c-s>"] = custom_actions.multi_selection_open_split,
				["<c-t>"] = custom_actions.multi_selection_open_tab,
			},
			n = {
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
				["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
				["<A-q>"] = actions.send_selected_to_qflist,
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
		initial_mode = "insert",
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
