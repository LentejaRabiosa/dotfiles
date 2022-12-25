-------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Load recent sessions
map("n", "<leader>sl", "<CMD>SessionLoad<CR>")

-- Back map keybind
map("n", "<leader>b", "<CMD>b#<CR>")

-- Keybindings for telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>")
map("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>ht", "<CMD>Telescope colorscheme<CR>")

-- :Ex command
map("n", "<leader>pe", "<CMD>Ex<CR>")

-- Tab width switch
map("n", "<leader>st", function()
	if vim.o.tabstop == 4 then
		vim.o.tabstop = 8
		vim.o.shiftwidth = 8
		print('Switching tabs to 8')
	elseif vim.o.tabstop == 8 then
		vim.o.tabstop = 4
		vim.o.shiftwidth = 4
		print('Switching tabs to 4')
	end
end)

-- List switch
local listState = 1;
map("n", "<leader>sl", function()
	if listState == 0 then
		vim.o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
		listState = 1
	elseif listState == 1 then
	vim.o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
		listState = 0
	end
end)

map("n", "<leader>sw", function()
	vim.o.list = not vim.o.list
end)

-- Compiler LaTeX to PDF and open
map("n", "<leader>lp", "<CMD>!pdflatex % ; open %:r.pdf<CR>")
