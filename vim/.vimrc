" vim:filetype=vim

" ========================= Vim-Plug Setup =========================
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

" ---- Language Support ----
Plug 'othree/html5.vim'
Plug 'othree/html5-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'vim-perl/vim-perl'
Plug 'digitaltoad/vim-pug'

" ---- Code Styling and Formatting ----
Plug 'prettier/vim-prettier'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'

" ---- Editor Enhancements ----
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'

" ---- File Navigation and Management ----
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

" ---- Git Integration ----
Plug 'tpope/vim-fugitive'

" ---- Tmux Integration ----
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'

" ---- Visual Enhancements ----
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" ========================= Custom Functions =========================
" Function to check for file existence in multiple locations
function! FileReadableInPaths(filename)
    let s:base_paths = ['/ndn', '~/ndn', '~/projects/ndn']
    let s:subdirs = ['', 'etc', 'perl/bin']

    for base in s:base_paths
        for subdir in s:subdirs
            let l:full_path = expand(base . (empty(subdir) ? '' : '/' . subdir) . '/' . a:filename)
            if filereadable(l:full_path)
                return l:full_path
            endif
        endfor
    endfor
    return ''
endfunction

" Function to run ALEFix on a selection range using temp buffer
function! ALEFixRange() range
    try
        " Remember the current window and position
        let l:winview = winsaveview()

        " Yank the selected text to register a
        silent execute a:firstline.','.a:lastline.'yank a'

        " Create a new temporary buffer
        new
        setlocal buftype=nofile bufhidden=hide noswapfile

        " Set the filetype to match the original file
        let &filetype = getbufvar(bufnr('#'), '&filetype')

        " Paste the yanked text
        silent put a

        " Remove the first blank line
        silent 1delete _

        " Run ALEFix on the temporary buffer
        ALEFix

        " Wait for ALE to finish
        while ale#engine#IsCheckingBuffer(bufnr('%'))
            sleep 100m
        endwhile

        " Give a little extra time for any final processing
        sleep 500m

        " Yank the fixed text
        silent %yank a

        " Close the temporary buffer
        bdelete!

        " Switch back to the original buffer and replace the selected text
        silent execute a:firstline.','.a:lastline.'delete _'
        silent execute a:firstline - 1 . 'put a'

        " Restore the view
        call winrestview(l:winview)

    catch
        " Display the error message persistently
        let l:error_message = "Error: " . v:exception
        echohl ErrorMsg
        echom l:error_message
        echohl None
    endtry
endfunction

" ========================= General Settings =========================
" Set mapleader
let mapleader=','

" Create backup and swap directories if they don't exist
" silent !mkdir -p ~/.vim/backup ~/.vim/swp
let s:vim_swp = expand('$HOME/.vim/swp')
let s:vim_cache = expand('$HOME/.vim/backup')
if filewritable(s:vim_swp) == 0 && exists("*mkdir")
    call mkdir(s:vim_swp, "p", 0700)
endif
if filewritable(s:vim_cache) == 0 && exists("*mkdir")
    call mkdir(s:vim_cache, "p", 0700)
endif

set backup
set showcmd
set mouse=a
set showmatch
set incsearch
set hlsearch
set splitright
set scrolloff=8
set wrap cindent
set numberwidth=2
set number relativenumber
set directory=~/.vim/swp//
set backupdir=~/.vim/backup//
set backspace=indent,eol,start

" ========================= Key Mappings =========================
" Toggle search highlighting
nnoremap <silent> <Space> :set hlsearch!<CR>

" Quicker buffer navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" Get to command line more quickly
nnoremap ; :

" Movement across wrapped lines
nnoremap j gj
nnoremap k gk
inoremap <up> <c-o>gk
inoremap <down> <c-o>gj

" Make F1 work as Escape
inoremap <F1> <ESC>
nnoremap <F1> <ESC>

" Disable shift+arrow keys in insert mode
inoremap <S-Up> <nop>
inoremap <S-Down> <nop>

" Use Q for formatting instead of Ex mode
map Q gq

" ========================= Language Settings =========================
" Default
set tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120 expandtab

" Language-specific settings
augroup language_settings
  autocmd!
  " HTML and CSS
  autocmd BufNewFile,BufRead *.html,*.css setlocal ts=2 sw=2 sts=2 expandtab

  " JavaScript, TypeScript, and Pug
  autocmd BufNewFile,BufRead *.js,*.jsx,*.ts,*.tsx,*.pug setlocal ts=2 sw=2 sts=2 expandtab

  " JSON
  autocmd BufNewFile,BufRead *.json setlocal ts=4 sw=4 sts=4 expandtab

  " Perl
  autocmd BufNewFile,BufRead *.pm,*.pl,*.t setlocal ts=4 sw=4 sts=0 noexpandtab

  " Python
  autocmd BufNewFile,BufRead *.py setlocal ts=4 sw=4 sts=4 expandtab textwidth=80
    \ formatoptions+=croq softtabstop=4
    \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with

  " Ruby
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal ts=2 sw=2 sts=2 expandtab
  autocmd BufNewFile,BufRead Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru setfiletype ruby

  " Markdown
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown textwidth=80 wrap spell

  " YAML
  autocmd BufNewFile,BufRead *.yml,*.yaml setlocal ts=2 sw=2 sts=2 expandtab

  " Shell scripts
  autocmd BufNewFile,BufRead *.sh setlocal ts=2 sw=2 sts=2 expandtab

  " Vim script
  autocmd BufNewFile,BufRead *.vim setlocal ts=2 sw=2 sts=2 expandtab

augroup END

" ========================= Colorscheme =========================
set t_Co=256

if has("termguicolors")
    set termguicolors
endif

let g:dracula_bold = 1
let g:dracula_italic = 1
let g:dracula_italic_comment = 1
let g:dracula_underline = 1
let g:dracula_high_contrast = 1
let g:dracula_colorterm = 1
colorscheme dracula

" ========================= Plugin Configurations =========================
" --- Vim-airline ---
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" --- Vim-better-whitespace ---
let g:better_whitespace_enabled=1
let g:better_whitespace_ctermcolor=255
let g:better_whitespace_guicolor='#FFFFFF'
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" --- ALE ---
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'pug': ['puglint', 'eslint'],
\   'perl': ['perltidy'],
\}
let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'pug': ['puglint', 'eslint'],
\   'perl': ['perlcritic'],
\}

" let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_history_log_output = 1
let g:ale_virtualtext_cursor = 'current'
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" --- Perltidy ---
" Find perltidyrc and partialtidy.pl
" TODO .perltidy also?
let s:perltidyrc = FileReadableInPaths('perltidyrc')

" Set perltidy options for ALE
let g:ale_perl_perltidy_options = s:perltidyrc != '' ? '-pro=' . s:perltidyrc : '-q'

" ALE mapping
nnoremap <Leader>af :ALEFix<CR>
vnoremap <Leader>af :call ALEFixRange()<CR>

" --- vim-jsx ---
let g:jsx_ext_required = 0

" --- Tagbar ---
nnoremap <silent> <F3> :TagbarToggle<CR>

" --- NERDTree ---
let NERDTreeShowHidden=1
map <F4> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --- NERDCommenter ---
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
