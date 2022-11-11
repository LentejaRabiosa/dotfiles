call plug#begin()
" Plug 'arzg/vim-colors-xcode' " XCode theme
Plug 'morhetz/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " Files

" Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons

" Plug 'nvim-tree/nvim-tree.lua'

" GIT INTEGRATION
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
" :GV!         # will only list commits that affected the current file
" :GV?         # fills the location list with the revisions of the current file
" :GV          # or :GV? can be used in visual mode to track the changes in the selected lines.

" CMP
Plug 'hrsh7th/nvim-cmp'
Plug 'delphinus/cmp-ctags'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-cmdline'

" VSNIP
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" NERDCommenter
Plug 'preservim/nerdcommenter'

" MARKDOWN
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" LaTex
Plug 'lervag/vimtex'
call plug#end()

filetype plugin on

source  ~/.config/nvim/plug-config/signify.vim
source  ~/.config/nvim/plug-config/nerdcommenter.vim
" source  ~/.config/nvim/plug-config/markdownpreview.vim
source  ~/.config/nvim/plug-config/vimtex.vim
luafile ~/.config/nvim/plug-config/cmp.lua
luafile ~/.config/nvim/plug-config/lspconfig.lua
luafile ~/.config/nvim/plug-config/treesitter.lua

" terminal background color: rgb(31, 33, 41)

" au ColorScheme * hi Normal ctermbg=none
" au ColorScheme * hi NonText ctermbg=none
" au ColorScheme * hi EndOfBuffer ctermbg=none
" au ColorScheme * hi LineNr ctermbg=none
" au ColorScheme * hi StatusLine ctermbg=none
" au ColorScheme * hi NonText ctermfg=gray

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
au ColorScheme * hi Comment cterm=italic

"""""""""""""""""""""""""""""
" COLORSCHEMES
"""""""""""""""""""""""""""""
" colorscheme xcodedark
" colorscheme xcodedarkhc
" colorscheme xcodelight
" colorscheme xcodelighthc
" colorscheme xcodewwdc
colorscheme gruvbox

"""""""""""""""""""""""""""""
" MAIN
""""""""""""""""""""""""""""" 
set nocompatible
syntax on
" set relativenumber
" set number
" set number relativenumber
" set cursorline

set sj=-50                  " emacs scroll like

set tabstop=4
set shiftwidth=4
set expandtab

set lazyredraw

set path+=**
set wildmenu

" set list
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

"""""""""""""""""""""""""""""
" BUFFERS
""""""""""""""""""""""""""""" 
nnoremap <C-b> :b#<CR>

"""""""""""""""""""""""""""""
" SPLITS
""""""""""""""""""""""""""""" 
set splitbelow splitright

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

noremap <A-h> :vertical resize +3<CR>
noremap <A-l> :vertical resize -3<CR>
noremap <A-k> :horizontal resize +3<CR>
noremap <A-j> :horizontal resize -3<CR>

map <Leader>th <C-w>t<C-w>h
map <Leader>tk <C-w>t<C-w>k

" set fillchars+=vert:\

"""""""""""""""""""""""""""""
" TELESCOPE
""""""""""""""""""""""""""""" 
noremap ff :Telescope find_files<CR>
noremap fg :Telescope live_grep<CR>
noremap fb :Telescope buffers<CR>
noremap <leader>fh <:Telescope help_tags<CR>
noremap gb :Telescope git_branches<CR>
noremap gc :Telescope git_commits<CR>
noremap fs :Telescope live_grep<CR>

"""""""""""""""""""""""""""""
" SNIPETS
""""""""""""""""""""""""""""" 
nnoremap <leader>{ o{<CR><CR>}<ESC>kA<tab>
" nnoremap <C-s>     Astd::cout <<  << std::endl;<ESC>4bhi
" nnoremap qc        I/* <ESC>A */<ESC>
" nnoremap <C-q>     I<Del><Del><Del><ESC>A<BS><BS><BS><ESC>
