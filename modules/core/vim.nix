{ config, pkgs, ... }:

{
  programs.vim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
      (pkgs.vim_configurable.customize {
        name = "vim";
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ delimitMate nerdtree catppuccin-vim gruvbox-material fzf-vim ]; # vim-autoclose is not packaged
        };
        vimrcConfig.customRC = ''
          " GENERAL BEHAVIOR ---------------------------------------------------------------- {{{

          " Disable compatibility with vi which can cause unexpected issues.
          set nocompatible

          " Backspace did not work by default on NixOS with vim_configurable
          set backspace=indent,eol,start

          " Enable type file detection. Vim will be able to try to detect the type of file in use.
          filetype on

          " Enable plugins and load plugin for the detected file type.
          filetype plugin on

          " Load an indent file for the detected file type.
          filetype indent on

          " TODO: Point to correct dir
          set undofile
          set undodir=$HOME/.vim/undos

          set number
          set relativenumber

          " Highlight cursor line underneath the cursor horizontally.
          set cursorline

          " Highlight cursor line underneath the cursor vertically.
          set cursorcolumn

          set timeoutlen=300
          " make escape work faster
          set ttimeoutlen=5

          set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

          " Do not wrap lines. Allow long lines to extend as far as the line goes.
          set nowrap

          " Enable auto completion menu after pressing TAB.
          set wildmenu

          " Make wildmenu behave like similar to Bash completion.
          set wildmode=longest:full,full

          " Set the commands to save in history (default number is 20).
          set history=1000

          set titlestring=%t
          set title

          set pastetoggle=<f5>

          set foldcolumn=1

          set foldmethod=marker

          " }}}

          " CURSOR ---------------------------------------------------------------- {{{

          " set cursor
          let &t_SI = "\e[6 q"  " insert mode
          let &t_SR = "\e[4 q"  " replace mode
          let &t_EI = "\e[2 q"  " normal mode

          " }}}

          " COLORS & THEME --------------------------------------------------------------- {{{

          " Default Colors for CursorLine
          highlight  CursorLineNr cterm=NONE ctermbg=Black ctermfg=White
          highlight  CursorLine cterm=NONE ctermbg=Black ctermfg=None

          " You might have to force true color when using regular vim inside tmux as the
          " colorscheme can appear to be grayscale with "termguicolors" option enabled.
          if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
          endif

          syntax on
          set termguicolors

          " colorscheme catppuccin_macchiato
          colorscheme gruvbox-material

          " }}}

          " SEARCH --------------------------------------------------------------- {{{

          " While searching though a file incrementally highlight matching characters as you type.
          set incsearch

          " Use highlighting when doing a search.
          " TODO: configure better hl color
          set hlsearch

          " Ignore capital letters during search.
          set ignorecase

          " Override the ignorecase option if searching for capital letters.
          " This will allow you to search specifically for capital letters.
          set smartcase

          " }}}

          " PLUGINS ---------------------------------------------------------------- {{{

          " Plugin code goes here.

          " }}}

          " MAPPINGS --------------------------------------------------------------- {{{

          let mapleader = " "
          set notimeout

          " Shortcut to rapidly toggle `set list`
          nnoremap <leader>l :set list!<CR>
          
          " Use the same symbols as TextMate for tabstops and EOLs
          set listchars=tab:▸\ ,eol:¬

          cnoremap sudow w !sudo tee % >/dev/null

          nnoremap <leader>n :NERDTreeFocus<CR>
          nnoremap <C-n> :NERDTree<CR>
          nnoremap <C-t> :NERDTreeToggle<CR>
          nnoremap <C-f> :NERDTreeFind<CR>

          " https://www.barbarianmeetscoding.com/blog/5-minutes-vim-ctrl-p-considered-harmful
          nnoremap <leader>s :<C-u>FZF<CR>

          " https://www.barbarianmeetscoding.com/blog/5-minutes-vim-moving-fast-within-a-file
          noremap H ^
          noremap L g_

          nnoremap <C-h> <C-w>h
          nnoremap <C-j> <C-w>j
          nnoremap <C-k> <C-w>k
          nnoremap <C-l> <C-w>l

          " }}}

          " VIMSCRIPT -------------------------------------------------------------- {{{

          " This will enable code folding.
          " Use the marker method of folding.
          augroup filetype_vim
              autocmd!
              autocmd FileType vim setlocal foldmethod=marker
          augroup END

          " NERDTREE

          " Exit Vim if NERDTree is the only window remaining in the only tab.
          autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

					" Close the tab if NERDTree is the only window remaining in it.
					" autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

          " }}}

          " STATUS LINE ------------------------------------------------------------ {{{

          " Show partial command you type in the last line of the screen.
          set showcmd

          " Show the mode you are on the last line.
          set showmode

          " always show status line
          set laststatus=2

          " show full path in status line
          "set statusline+=%F
          "set statusline+=%F\ %l\:%c
          "set statusline+=col:\ %c

          function! GitBranch()
            return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
          endfunction

          function! StatuslineGit()
            let l:branchname = GitBranch()
            return strlen(l:branchname) > 0?'  '.l:branchname.' ':\'\'
          endfunction

          set statusline=%F%m%r%h\ %y%=[%03p%%]\ [%03l:%02v]\ [%L]
          " set statusline=%f%m%r%h\ [%L]\ [%{&ff}]\ %y%=[%03p%%]\ [line:%05l,col:%02v]

          " }}}

          set path+=~/10-projects/nixos/**
          set path+=~/10-projects/blog/**
        '';
      })
    ];
}
