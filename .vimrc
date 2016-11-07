set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'             " Vundle
Plugin 'OmniCppComplete'                  " completion
Plugin 'AutoComplPop'                     " autmatically pop up the completion
Plugin 'scrooloose/nerdtree'              " open a file tree in vim Ctrl N
Plugin 'Xuyuanp/nerdtree-git-plugin'      " show git status for the files
" Plugin 'tpope/vim-fugitive'             " a git wrapper
Plugin 'bling/vim-airline'                " vim statusline
Plugin 'nathanaelkane/vim-indent-guides'  " indent guides for code
Plugin 'bronson/vim-trailing-whitespace'  " mark trailing whitespaces and delete them
Plugin 'scrooloose/syntastic'             " populate the syntax checker for coding on save
Plugin 'Chiel92/vim-autoformat'           " autoformat on keystroke or save
Plugin 'easymotion/vim-easymotion'        " provides somenice movement through vim
Plugin 'ervandew/supertab'                " make completionswith tab instead of enter
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'          " markdown syntax highlight
Plugin 'vim-auto-save'                    " periodiacally save Buffer
Plugin 'vim-latex/vim-latex'              " latex support for vim

filetype plugin indent on

set t_Co=256
colorscheme distinguished
set mouse=a
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set relativenumber
set number
set encoding=utf-8
syntax on
set nofoldenable
set guioptions-=r
set guioptions-=L
set guioptions-=T

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

" nerdtree settings

" open nerdtree if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" map Ctrl+n to toggle the tree
map <C-n> :NERDTreeToggle<CR>
" close vim if nerdtree is the last open tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nerdtree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }

" powerline/airline

" always show statusline
set laststatus=2
" activate powerline-font and symbol
let g:airline_powerline_fonts=1
" set theme
let g:airline_theme='bubblegum'


" indent-guides

" enable automatically
autocmd VimEnter * IndentGuidesEnable
" don't use the default colors but these from the colorscheme
let g:indent_guides_auto_colors=0
" make the guide size smaller
let g:indent_guides_guide_size=1
" draw the guide at the first space
set et

" omnicomplete cpp
set tags+=~/.vim/tags/cpp
map <F1> :!ctags -R --sort=yes --c++-kinds=+p --fields-+iaS --extra=+q .<CR>

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
au BufNewFile,BufRead,BufEnter *.c set omnifunc=ccomplete#Complete

" autoformat settings
let g:formatdef_clangformat = '"clang-format -style=file"'
au BufWrite [^.md] :Autoformat

" trailing whitespaces on write
au BufWrite * :FixWhitespace

" easymotion
map <Leader> <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
let g:EasyMotion_startofline=0
nmap s <Plug>(easymotion-s2)

" markdown disable folding
let g:vim_markdown_folding_diabled=1
autocmd BufNewFile,BufRead *.md :silent !chromium %

" autosave
"let g:auto_save = 1
"let g:auto_save_in_insert_mode = 0

" vim-latex
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_IgnoreLevel=7
let g:tex_flavor='latex'
" save file before compiling
autocmd FileType tex call Tex_MakeMap("<Leader>ll", ":w <CR> <Plug>Tex_Compile", 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap("<Leader>ll", "<ESC> :w <CR> <Plug>Tex_Compile", 'v', '<buffer>')

" zsh-theme syntax -> zsh
au BufEnter *.zsh-theme set syntax=zsh
