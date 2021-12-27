colorscheme PaperColor
"colorscheme palenight

let mapleader = "\<space>"

filetype plugin indent on
" textEdit might fail if hidden is not set.
set hidden
" some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set updatetime=300
set sessionoptions+=winpos,terminal
" don't pass messages to |ins-completion-menu|
set shortmess+=c

set expandtab
set number
set autoindent
set tabstop=2
set shiftwidth=2
" always show signs column
set scl=yes
" mouse enabled in all modes
set mouse=a
set encoding=UTF-8
set background=dark
set splitbelow
set splitright

" Searching {
set smartcase
" set ignorecase
" }

" Line size {
set colorcolumn=100
highlight ColorColumn ctermbg=0
highlight CursorColumn ctermbg=none ctermfg=magenta
" set signcolumn for new buffers
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
" }

" Disable spell since the plugin Spelunker will also highlight
"set nospell
set spell
set spelllang=en_us
set noshowmode
" do not show the file name
set shortmess+=F

" don’t reset cursor to start of line when moving around.
set nostartofline

" wildignore {
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*/.git/*,*.DS_Store
set wildignore+=*/node_modules/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*
" } wildignore

" delete to blackhole register
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c

" Prepare replace of current word
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" remap C-c to esc in insert mode
inoremap <C-c> <esc>
nnoremap ; :

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

" quick-save
nmap <Leader>w :w<CR>
nnoremap <silent> Q <nop>

" replaces the word under the cursor downwards. press . to repeat
nnoremap <Leader>c* *``cgn
" upwards
nnoremap <Leader>c# *``cgn
" delete word
nnoremap <Leader>d* *``cgn
" close buffer without changing window layout
nnoremap :: :bp\|bd #<CR>
" close current split
nnoremap <Leader>q <C-w>q
" copy from cursor to end of line
nnoremap Y y$
"jump next/prev but centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Opens line below or above the current line
inoremap <S-CR> <C-O>o
inoremap <C-CR> <C-O>O

" Moving lines up or down preserving format {
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==gi
inoremap <C-k> <esc>:m .-2<CR>==gi
nnoremap <Leader>j :m .+1<CR>==
nnoremap <Leader>k :m .-2<CR>==
" }

" Navigate windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows
nnoremap <C-Up> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Navigate buffers
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>

" new buffer vertical split
nnoremap <Leader>vs :vnew<cr>
" select everything
nnoremap <C-A> ggVG
" open new file adjacent to current file
nnoremap <Leader>o :e <C-R>=expand("%:p:h") . "/" <CR>
" toggle between buffers current and prev buffer
nnoremap <Leader><Leader> <C-^>

nnoremap p p=`]
nnoremap <C-p> p
" Function to set tab width to n spaces
function! SetTab(n)
  let &l:tabstop=a:n
  let &l:softtabstop=a:n
  let &l:shiftwidth=a:n
  set expandtab
endfunction

fun! EmptyRegisters()
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfun

command! -nargs=1 SetTab call SetTab(<f-args>)

" Function to trim extra whitespace in whole file
function! Trim()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()

autocmd BufWritePre * :%s/\s\+$//e

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

" custom function to fold blocks
function! CFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction

set foldtext=CFoldText()
set foldmethod=expr

