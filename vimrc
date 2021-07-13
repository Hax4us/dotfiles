"" vimrc configuration
"================================================
"" Plugings
"================================================
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'

Plug 'yggdroot/indentline'

Plug 'preservim/nerdcommenter'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'crusoexia/vim-monokai'

" Plug 'SirVer/ultisnips'

Plug 'honza/vim-snippets'

call plug#end()

filetype on
filetype plugin on
filetype plugin indent on

"================================================
"" General settings
"================================================

"------ Meta ------"
" clear all autocommands! (this comment must be on its own line)
autocmd!

set timeout timeoutlen=5000
set nocompatible                " break away from old vi compatibility
set fileformats=unix,dos,mac    " support all three newline formats
set viminfo=                    " don't use or save viminfo files
source $VIMRUNTIME/defaults.vim		" Get the defaults that most users want

"------ Console UI & Text display ------"
set cmdheight=1                 " explicitly set the height of the command line
set showcmd                     " Show (partial) command in status line.
set number                      " yay line numbers
set ruler                       " show current position at bottom
set noerrorbells                " don't whine
set visualbell t_vb=            " and don't make faces
set lazyredraw                  " don't redraw while in macros
set scrolloff=3                 " keep at least 5 lines around the cursor
"set nowrap                        " soft wrap long lines
set nolist                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set report=0                    " report back on all changes
set shortmess=atI               " shorten messages and don't show intro
set wildmenu                    " turn on wild menu :e <Tab>
set wildmode=list:longest       " set wildmenu to list choice
set termguicolors

"------ Text editing and searching behavior ------"
set clipboard=unnamed	" yank to the system register (*) by default
set nohlsearch                  " turn off highlighting for searched expressions
set incsearch                   " highlight as we search however
set matchtime=5                 " blink matching chars for .x seconds
set mouse=a                     " try to use a mouse in the console (wimp!)
set ignorecase                  " set case insensitivity
set smartcase                   " unless there's a capital letter
set completeopt=menu,longest,preview " more autocomplete <Ctrl>-P options
set nostartofline               " leave my cursor position alone!
set backspace=2                 " equiv to :set backspace=indent,eol,start
set textwidth=80                " we like 80 columns
set showmatch                   " show matching brackets
set iskeyword+=_,$,@,%,#,-		"not to split word"
set formatoptions=tcrql         " t - autowrap to textwidth
                                " c - autowrap comments to textwidth
                                " r - autoinsert comment leader with <Enter>
                                " q - allow formatting of comments with :gq
                                " l - don't format already long lines

"------ Indents and tabs ------"
set autoindent                  " set the cursor at same indent as line above
set smartindent                 " try to be smart about indenting (C-style)
set expandtab                   " expand <Tab>s with spaces; death to tabs!
set shiftwidth=4                " spaces for each step of (auto)indent
set softtabstop=4               " set virtual tab stop (compat for 8-wide tabs)
set tabstop=4                   " for proper display of files with tabs
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents
set preserveindent              " save as much indent structure as possible
filetype plugin indent on       " load filetype plugins and indent settings

"------ History,backup and swapfile ------"
set confirm                     " prompt to save when modified
set history=1000
set nobackup
set noswapfile
set autoread		" auto read when file is changed from outside

"------ netrw ------"
" let g:netrw_sort_by = 'time'
" let g:netrw_sort_direction = 'reverse'
let g:netrw_browse_split = 4
" let g:netrw_liststyle = 3
let g:netrw_banner = 0
" let g:netrw_winsize = 25

"------ general key bindings ------"
" select all
nnoremap <C-a> gg0vG$
inoremap <C-a> <ESC>gg0vG$
" Ctrl + s to save
inoremap <C-s> <ESC>:w<CR>a

"================================================
" theme
"================================================
"------ colorscheme ------"
":colorscheme monokai
" :set background=light
" :set background=dark
syntax on
colorscheme monokai 

"------ hilight ------"
" --- Popup menu
" :hi Pmenu ctermfg=16 ctermbg=252 cterm=NONE guifg=#697383 guibg=#d3d1cc gui=NONE
" :hi PmenuSel ctermfg=16 ctermbg=45 cterm=bold guifg=#555f6f guibg=#bdbbb6 gui=bold
" :hi PmenuSbar ctermbg=188 cterm=NONE guibg=#dfddd7 gui=NONE
" :hi PmenuThumb ctermbg=247 cterm=NONE guibg=#929cad gui=NONE
" --- coc highlight
" ---  error
" :hi CocErrorSign ctermfg=124 ctermbg=NONE
" :hi CocErrorHighlight ctermfg=124 ctermbg=NONE cterm=underline,bold guifg=#697383 guibg=#d3d1cc gui=NONE
:highlight CocErrorFloat ctermfg=red ctermbg=white
" ---  warning
" :hi CocWarningSign ctermfg=124 ctermbg=NONE cterm=bold guifg=#697383 guibg=#d3d1cc gui=NONE
" :hi CocWarningHighlight ctermfg=124 ctermbg=252 cterm=NONE guifg=#697383 guibg=#d3d1cc gui=NONE
" :hi CocWarningFloat ctermfg=124 ctermbg=252 cterm=NONE guifg=#697383 guibg=#d3d1cc gui=NONE

"================================================
"" run code
"================================================
"press F5 to run C, C++...
map <F5> :call RunCode()<CR>
inoremap <F5> <ESC>:call RunCode()<CR>
func! RunCode()
    if &filetype == 'c' || &filetype == 'cpp'
        exec "w"
        exec "ter ++shell clang % -o %< ; ./%<"
    elseif &filetype == 'java'
        " if JavaRun is installed and is has src folder
        if exists('*JavaRun') && fnamemodify(getcwd(), ':t') == "src"
            exec "JavaRun"
        " no JavaRun
        else
            exec "w"
            exec "term java %"
        endif
    elseif &filetype == 'python'
        exec "w"
        exec "term python %"
    elseif &filetype == 'sh'
        exec "w"
        exec "term bash %"
    elseif &filetype == 'vim'
        exec "w"
        exec "source %"
    else 
        echo "this is a " &filetype "file!"
    endif
endfunc
"debug C, C++...
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

"================================================
" Plugin settings
"================================================
"------ lightline settings ------"
set laststatus=2
if !has('gui_running')
    set t_Co=8
endif
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'component_function': {
      \   'fileformat': 'LightlineFileformat',
      \   'fileencoding': 'LightLineFileencoding',
      \   'filetype': 'LightlineFiletype',
      \ },
      \ }

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFileencoding() 
    if empty(get(g:, 'coc_status', '')) && empty(get(b:, 'coc_diagnostic_info', {})) 
        return winwidth(0) < 70 ? &fileformat : &fileencoding
    endif
    return trim(coc#status())
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

"------ commenter ------"
let mapleader=","

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"================================================
"" COC settings
"================================================
let g:coc_disable_startup_warning=1
"------ COC DEFALUT CONFIGURATION ------"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" coc-snippets confs
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"------ END CONFIGURATION ------"
" coc-react-refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" coc-java-debug
" function! JavaStartDebugCallback(err, port)
"   execute "cexpr! 'Java debug started on port: " . a:port . "'"
"   call vimspector#LaunchWithSettings({ "configuration": "Java Attach", "AdapterPort": a:port })
" endfunction
"
" function JavaStartDebug()
"   call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('JavaStartDebugCallback'))
" endfunction
"
" nmap <F5> :call JavaStartDebug()<CR>
"
"highlight CocErrorFloat ctermfg=red ctermbg=white

augroup mygroup2
   autocmd!
   autocmd VimEnter * highlight CocErrorFloat ctermfg=red ctermbg=white
augroup end

"autocmd VimEnter * highlight CocErrorFloat ctermfg=red ctermbg=white
