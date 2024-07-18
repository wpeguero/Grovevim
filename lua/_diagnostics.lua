require('gitsigns').setup {
	signs                        = {
		add          = { text = '│' },
		change       = { text = '│' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir                 = {
		follow_files = true
	},
	attach_to_untracked          = true,
	current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts      = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
	sign_priority                = 6,
	update_debounce              = 100,
	status_formatter             = nil, -- Use default
	max_file_length              = 40000, -- Disable if file is longer than this (in lines)
	preview_config               = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
}

require('trouble').setup
{
	modes = {
		cascade = {
			mode = "diagnostics", -- inherit from diagnostics mode
			filter = function(items)
				local severity = vim.diagnostic.severity.HINT
				for _, item in ipairs(items) do
					severity = math.min(severity, item.severity)
				end
				return vim.tbl_filter(function(item)
					return item.severity == severity
				end, items)
			end,
		},
	},
}
