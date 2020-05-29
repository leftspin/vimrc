


" This vimrc attempts to be nvim/vim agnostic, but it's a better experience in
" nvim.


" git-plug plugin manager ______________________________________________________
"
if has('nvim') " we are nvim bl

    call plug#begin(stdpath('data') . '/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} 

else " we are plain old vim

    " because plain old vim doesn't change the cursor
    " shape for us in insert mode
    let &t_SI.="\e[5 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

    call plug#begin('~/.vim/plugged')
" Plug 'peitalin/vim-jsx-typescript'

endif

" these syntax highlighters are also active for vim
" even though vim 8.2 has built-in support because
" the built-in support is crappy. When it's no longer
" crappy, this should be moved into the vim block above
" Plug 'leafgarland/typescript-vim'
" Plug 'ianks/vim-tsx'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rhubarb'
Plug 'lilyball/vim-swift'
Plug 'bkad/CamelCaseMotion'
Plug 'joshdick/onedark.vim'

" post install (yarn install | npm install) then load plugin only for editing
" supported files
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()


" Theme stuff __________________________________________________________________
"
"
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    " set t_8f=[38;2;%lu;%lu;%lum
    " set t_8b=[48;2;%lu;%lu;%lum
    set termguicolors
  endif
endif

" onedark.vim override: Set a custom background color in the terminal
 if (has("autocmd") && !has("gui_running"))
   augroup colors
     autocmd!
     let s:background = { "gui": "#080c14", "cterm": "6", "cterm16": "4" }
     autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
   augroup END
 endif

let g:onedark_terminal_italics=1

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

if (has("autocmd"))
  augroup colorextend
    autocmd!
    autocmd ColorScheme * call onedark#extend_highlight("Keyword", { "gui": "italic" })
    autocmd ColorScheme * call onedark#extend_highlight("Conditional", { "gui": "italic" })
    autocmd ColorScheme * call onedark#extend_highlight("Repeat", { "gui": "italic" })
    autocmd ColorScheme * call onedark#extend_highlight("Label", { "gui": "italic" })
    autocmd ColorScheme * call onedark#extend_highlight("Exception", { "gui": "italic" })
    autocmd ColorScheme * call onedark#extend_highlight("Special", { "gui": "italic" })
    autocmd ColorScheme * call onedark#extend_highlight("Function", { "gui": "bold" })
  augroup END
endif

" *cterm-colors*

" NR-16   NR-8    COLOR NAME 
" 0       0       Black
" 1       4       DarkBlue
" 2       2       DarkGreen
" 3       6       DarkCyan
" 4       1       DarkRed
" 5       5       DarkMagenta
" 6       3       Brown, DarkYellow
" 7       7       LightGray, LightGrey, Gray, Grey
" 8       0*      DarkGray, DarkGrey
" 9       4*      Blue, LightBlue
" 10      2*      Green, LightGreen
" 11      6*      Cyan, LightCyan
" 12      1*      Red, LightRed
" 13      5*      Magenta, LightMagenta
" 14      3*      Yellow, LightYellow
" 15      7*      White


" highlight LineNr ctermfg=darkgrey
" highlight CursorLineNr ctermfg=white
" highlight Pmenu ctermbg=DarkGray guibg=DarkGray ctermfg=White guifg=White
" highlight PmenuSel ctermbg=DarkCyan guibg=DarkCyan ctermfg=Black guifg=Black
" highlight PmenuThumb ctermbg=Yellow guibg=Yellow
" highlight PmenuSbar ctermbg=Black guibg=Black

highlight Cursor guibg=DarkCyan
set guicursor=n-v-c:Cursor-block,i-ci-cr:Cursor-ver20-blinkon1000-blinkoff100-blinkwait100

colorscheme onedark


" Settings _____________________________________________________________________
"

set laststatus=2 " needed for lightline
set shell=zsh\ -i
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set noshowmode " disables -- INSERT -- which is provided by lightline
set wrap
set linebreak
set list listchars=tab:»·,trail:·
set ls=2

" Config _______________________________________________________________________
"

" Rhubarb Gbrowse
let g:github_enterprise_urls = ['https://github.cbhq.net']

augroup numbertoggle
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter     * set number relativenumber
  autocmd WinLeave                          * set norelativenumber nonumber
augroup END

" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, info['error'] . ' Errors')
  endif
  if get(info, 'warning', 0)
    call add(msgs, info['warning'] . ' Warnings')
  endif
  return join(msgs, ' ')
endfunction

let g:lightline = {
        \   'colorscheme': 'onedark',
        \   'active': {
        \     'left': [ [ 'mode', 'paste' ],
        \               [ 'readonly', 'gitbranch', 'relativepath', 'coc', 'gutentags', 'modified' ] ]
        \   },
        \   'component': {
        \   },
        \   'component_function': {
        \     'gitbranch': 'FugitiveHead',
        \     'gutentags': 'gutentags#statusline',
        \     'coc':       'StatusDiagnostic'
        \   },
        \ }

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

 if has('linebreak')
   set breakindent
   let &showbreak = '⤷ '
   set cpo+=n
 end

" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
" https://medium.com/@s1n7ax/neovim-for-typescript-react-development-fdc7082c8a78
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx,*.jsx setlocal filetype=typescript.tsx


" prettier runs after existing insert
"
if !has('nvim')
    autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
endif

" move tags to a single directory
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']


" Commands _____________________________________________________________________
"
command! Rc e $MYVIMRC
command! Sorc so $MYVIMRC
command! Conflicts Ag<<<<<<


" Utility functions ____________________________________________________________
"

" fill to end of line using —
function! FillLine( str )
    " set tw to the desired total length
    let tw = 80
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

" coc.nvim config

if has('nvim')

    " coc extensions
    let g:coc_global_extensions = [
            \ 'coc-tslint-plugin', 
            \ 'coc-tsserver', 
            \ 'coc-emmet', 
            \ 'coc-css', 
            \ 'coc-html', 
            \ 'coc-json', 
            \ 'coc-yank', 
            \ 'coc-eslint',
            \ 'coc-prettier' 
            \ ]
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
    set signcolumn=yes

    highlight CocErrorFloat ctermfg=red
    highlight CocWarningFloat ctermfg=yellow
    highlight CocInfoFloat ctermfg=white
    highlight CocHintFloat ctermfg=white
    highlight CursorLine guibg=#000020
    highlight Visual guibg=#000020
    highlight LineNr guifg=#a0a0a0
    highlight CursorLineNr guifg=white

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
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if has('patch8.1.1068')
      " Use `complete_info` if your (Neo)Vim version supports it.
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
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
      else
        call CocAction('doHover')
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

    " Remap keys for applying codeAction to the current line.
    nmap <space>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <space>qf  <Plug>(coc-fix-current)

    " Introduce function text object
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

endif


" Mappings _____________________________________________________________________
"
map <C-n> :NERDTreeToggle<CR>
map <silent> <space>- :call FillLine('_')<CR>
map <silent> <space>o :Files<CR>
map <silent> <space>p :Format<CR>
map <silent> <space>b :bn<CR>
map <silent> <space>B :Buffers<CR>
map <silent> <space>f :BLines<CR>
map <silent> <space>F :Tags<CR>
map <silent> <space>i :lopen<CR>
map <silent> <space>I :lopen<CR>:q<CR>
map <silent> <space>w :bd<CR>
map <silent> <space>W :bd!<CR>
map <silent> <space>j :call CocAction('diagnosticNext')<CR>
map <silent> <space>k :call CocAction('diagnosticPrevious')<CR>
map <silent> <C-h> xh
map <silent> <space><CR> <Plug>(coc-fix-current)
map <silent> <space>O :Files %:p:h<CR>
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge
map <silent> <space>n :noh<CR>
map <silent> <space>/ :CocList outline<CR>
