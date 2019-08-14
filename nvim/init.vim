" Clipboard everywhere!
set clipboard+=unnamedplus
" Hybrit line numbers
set number relativenumber
"colorscheme peachpuff
" Remember last scroll position
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

"┌────────────────┐
"│ KEYBOARD REMAP │
"└────────────────┘
" kj => Esc in insert mode, Ctrl+c in command mode
inoremap kj <Esc>
cnoremap kj <C-C> 
" Lets save without leaving insert mode
inoremap <C-S> <Esc>:w<CR>a
" And save after going to another line in insert mode
"inoremap <CR> <Esc>:w<CR>a<CR>
"inoremap <Up> <Esc>:w<CR>a<Up>
"inoremap <Down> <Esc>:w<CR>a<Down>

" Run :make after pressing the refresh button (or F5 on my keyboard)
nmap <F5> :make<CR>
imap <F5> <Esc>:w<CR>:make<CR>
" Make :make actually :make run in rust files
autocmd FileType rust cmap make make<Space>run

" F12 => Jump to definition
nmap <F12> :ALEGoToDefinition<CR>
imap <F12> <Esc>:ALEGoToDefinition<CR>

"┌─────────┐
"│ PLUGINS │
"└─────────┘
call plug#begin('~/.config/nvim/plugged')

" Latex plugin
Plug 'lervag/vimtex'

" Snippets plugin
Plug 'sirver/ultisnips'

" Colored parenthesis (LISP)
Plug 'junegunn/rainbow_parentheses.vim'

" Rust
Plug 'rust-lang/rust.vim'

" Asynchronous Lint Engin (make nvim IDE again!)
Plug 'w0rp/ALE'

" Airline (the bar at the bottom)
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Lightline (the bar at the bottom)
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Deoplete (autocompletion)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" TabNine (autocompletion)
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" Racer (autocompletion)
Plug 'racer-rust/vim-racer'

call plug#end()


"┌─────────────────┐
"│ PLUGIN SETTINGS │
"└─────────────────┘

" Don't change appearance for concealed characters (LaTeX)
hi! link Conceal Normal

" Autoenable RainbowParenthese on lisp files
augroup rainbow_lisp
	autocmd!
	autocmd FileType lisp,clojure,scheme RainbowParenthese
augroup END

" Latex plugin, use mupdf as default pdf viewer
let g:vimtex_view_method='mupdf'
let g:tex_flavor='xelatex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmgs'

" Snippets
let g:UtilSnipsExpandTrigger = '<tab>'
let g:UtilSnipsJumpForwardTrigger = '<tab>'
let g:UtilSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir = '~/.config/nvim/ultisnippets'
let g:UltiSnipsSnippetDirectories = ['ultisnippets']

" Lightline
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

" Deoplete
let g:deoplete#enable_at_startup = 1
" '_': ['ale', 'tabnine'],
call deoplete#custom#option('sources', {
\ '_': ['ale', 'tabnine'],
\})

" Close preview window after autocompletion is done
autocmd CompleteDone * silent! pclose!
" Remap Ctrl+Space to Ctrl+N (autocomplete select/next)
inoremap <C-Space> <C-N>

" Make ALE work properly with rust
let g:ale_linters = {'rust': ['rls']}
let g:ale_fixers = { 'rust': ['rustfmt']}
" Change how often 
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 1
" And change colors
highlight ALEWarning ctermbg=DarkYellow
highlight ALEError ctermbg=DarkRed
