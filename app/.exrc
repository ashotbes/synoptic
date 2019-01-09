let s:cpo_save=&cpo
set cpo&vim
imap <S-Tab> <Plug>SuperTabBackward
inoremap <C-Tab> 	
inoremap <silent> <SNR>25_AutoPairsReturn =AutoPairsReturn()
nnoremap <silent>  :call comfortable_motion#flick(-200)
nnoremap <silent>  :call comfortable_motion#flick(100)
nnoremap <silent>  :call comfortable_motion#flick(200)
map  :NERDTreeToggle
nnoremap <silent>  :CtrlP
nnoremap <silent>  :call comfortable_motion#flick(-100)
tnoremap  
nnoremap ; :
vmap [% [%m'gv``
vmap ]% ]%m'gv``
vmap a% [%v]%
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
nnoremap <SNR>95_: :=v:count ? v:count : ''
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
nnoremap <silent> <Plug>GitGutterPreviewHunk :GitGutterPreviewHunk
nnoremap <silent> <Plug>GitGutterUndoHunk :GitGutterUndoHunk
nnoremap <silent> <Plug>GitGutterStageHunk :GitGutterStageHunk
nnoremap <silent> <expr> <Plug>GitGutterPrevHunk &diff ? '[c' : ":\execute v:count1 . 'GitGutterPrevHunk'\"
nnoremap <silent> <expr> <Plug>GitGutterNextHunk &diff ? ']c' : ":\execute v:count1 . 'GitGutterNextHunk'\"
xnoremap <silent> <Plug>GitGutterTextObjectOuterVisual :call gitgutter#hunk#text_object(0)
xnoremap <silent> <Plug>GitGutterTextObjectInnerVisual :call gitgutter#hunk#text_object(1)
onoremap <silent> <Plug>GitGutterTextObjectOuterPending :call gitgutter#hunk#text_object(0)
onoremap <silent> <Plug>GitGutterTextObjectInnerPending :call gitgutter#hunk#text_object(1)
noremap <Right> <Nop>
noremap <Left> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>
imap 	 <Plug>SuperTabForward
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set clipboard=unnamedplus
set expandtab
set helplang=ru
set makeprg=stack\ install
set mouse=a
set runtimepath=~/.config/nvim,~/.local/share/nvim/plugged/base16-vim/,~/.local/share/nvim/plugged/vim-solarized8/,~/.local/share/nvim/plugged/nova.vim/,~/.local/share/nvim/plugged/moriarty.vim/,~/.local/share/nvim/plugged/vim-airline-themes/,~/.local/share/nvim/plugged/vim-devicons/,~/.local/share/nvim/plugged/vim-stylish-haskell/,~/.local/share/nvim/plugged/hlint/,~/.local/share/nvim/plugged/vim-fugitive/,~/.local/share/nvim/plugged/vim-gitgutter/,~/.local/share/nvim/plugged/ctrlp.vim/,~/.local/share/nvim/plugged/comfortable-motion.vim/,~/.local/share/nvim/plugged/ack.vim/,~/.local/share/nvim/plugged/auto-pairs/,~/.local/share/nvim/plugged/deoplete.nvim/,~/.local/share/nvim/plugged/haskell-vim/,~/.local/share/nvim/plugged/neco-ghc/,~/.local/share/nvim/plugged/nerdtree/,~/.local/share/nvim/plugged/supertab/,~/.local/share/nvim/plugged/tabular/,~/.local/share/nvim/plugged/vim-airline/,~/.local/share/nvim/plugged/vim-nix/,/etc/xdg/xdg-ubuntu/nvim,/etc/xdg/nvim,~/.local/share/nvim/site,/usr/share/ubuntu/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/var/lib/snapd/desktop/nvim/site,/usr/share/nvim/runtime,/var/lib/snapd/desktop/nvim/site/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/usr/share/ubuntu/nvim/site/after,~/.local/share/nvim/site/after,/etc/xdg/nvim/after,/etc/xdg/xdg-ubuntu/nvim/after,~/.local/share/nvim/plugged/haskell-vim/after,~/.local/share/nvim/plugged/tabular/after,~/.config/nvim/after
set shellpipe=>
set shiftwidth=4
set softtabstop=4
set statusline=%#warningmsg#
set noswapfile
set termguicolors
set timeoutlen=5
set window=27
" vim: set ft=vim :
