call plug#begin()
" Plug 'preservim/nerdtree'
Plug 'arzg/vim-colors-xcode' " Theme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax support
Plug 'nvim-lua/plenary.nvim' " No idea xd
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " Files
call plug#end()

" terminal background color: rgb(31, 33, 41)

au ColorScheme * hi Normal ctermbg=none
au ColorScheme * hi NonText ctermbg=none
au ColorScheme * hi EndOfBuffer ctermbg=none
au ColorScheme * hi LineNr ctermbg=none
au ColorScheme * hi StatusLine ctermbg=none

"""""""""""""""""""""""""""""
" COLORSCHEMES
"""""""""""""""""""""""""""""
" colorscheme xcodedark
" colorscheme xcodedarkhc
" colorscheme xcodelight
" colorscheme xcodelighthc
colorscheme xcodewwdc

"""""""""""""""""""""""""""""
" BOX
"""""""""""""""""""""""""""""
command Box :echo '╭  ╮ ╰ ╯ ─ │ ┬ ┴ ├ ┤ ┼'

"""""""""""""""""""""""""""""
" MAIN
""""""""""""""""""""""""""""" 
set nocompatible
syntax enable
filetype plugin on
set number relativenumber
set cursorline
" nmap <F6> :NERDTreeToggle<CR>
set tabstop=4
set shiftwidth=4
set expandtab

set path+=**
set wildmenu

command! MakeTags !ctags -R .
" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

set splitbelow splitright

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :horizontal resize +3<CR>
noremap <silent> <C-Down> :horizontal resize -3<CR>

map <Leader>th <C-w>t<C-w>h
map <Leader>tk <C-w>t<C-w>k

set fillchars+=vert:\

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
nnoremap <C-s>     Astd::cout <<  << std::endl;<ESC>4bhi
