-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- [[ Setting options ]] See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Print the line number in front of each line
vim.o.number = true

-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
-- option above, see `:h number_relativenumber`
vim.o.relativenumber = false

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Show <tab> and trailing spaces
vim.o.list = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Create user commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`

vim.o.tabstop = 4
vim.o.shiftwidth = 4

--[[Run the LaTeX compile script]]
vim.keymap.set('n', '<F6>', ':!pdflatex_kate %<CR>', {silent = true, noremap = true})

--[[Run the LaTeX compile script in KEY mode]]
vim.keymap.set('n', '<leader><F6>', ':!pdflatex_kate_KEY %<CR>', {silent = true, noremap = true})

--[[Run Okular on the current file]]
vim.keymap.set('n', '<F7>', ':!okular_lua %<CR>', {silent = true, noremap = true})

-- Open the current file in Typora
vim.keymap.set('n', '<F9>', ':silent! !io.typora.Typora % > /dev/null 2>&1 &<CR>', {silent = true})

-- Lua: Comment out the selected visual block
vim.keymap.set('v', '<leader>lc', ":<C-u>'<normal! O--[[<CR>:'>normal! o]]<CR>", {silent = true})

-- Lua: Comment out current line
vim.keymap.set('n', '<leader>lc', "mcI--[[<Esc>A]]<Esc>`cllll", {silent = true})

-- Lua: Remove comment from current line
vim.keymap.set('n', '<leader>llc', "mc0xxxx$xx`chhhh", {silent = true})

-- Python: Comment out the selected visual block
vim.keymap.set('v', '<leader>pc', ":<C-u>'<normal! O\"\"\"<CR>:'>normal! o\"\"\"<CR>", {silent = true})

--local function comment_wrap()
	--local start_pos = vim.fn.getpos("'<")
	--local end_pos = vim.fn.getpos("'>")

	--vim.api.nvim_buf_set_text(0,
		--start_pos[2]-1, start_pos[3]-1,
		--start_pos[2]-1, start_pos[3]-1,
		--{']]'})
	--end_pos[2] = end_pos[2]+1
	--vim.api.nvim_buf_set_text(0,
		--end_pos[2]-1, end_pos[3],
		--end_pos[2]-1, end_pos[3],
		--{'--[['})
--end
--vim.keymap.set('x', '<leader>c', comment_wrap, { silent = true })


-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })

-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
vim.cmd('packadd! nohlsearch')
