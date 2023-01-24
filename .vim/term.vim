" .vimrc
" .vim/term.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Terminal settings
" ----------------------------------------------------------------------

set ttyfast         " fast terminal connection

" NOTE: Hold SHIFT (or CTRL+SHIFT) during selection to disable visual mode!
set mouse=a         " turn mouse on in all modes
" set mouse=vicr      " turn mouse on in all modes

" Set correct ttymouse
if &term =~ 'tmux'
  " In tmux mouse support works only with xterm2
  set ttymouse=xterm2
else
  " Everywhere else (including screen) use sgr
  set ttymouse=sgr
endif

" set balloonevalterm

" Fix escape sequences
" See: https://github.com/kovidgoyal/kitty/blob/master/docs/faq.rst#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_Ts = "\e[9m"         " strikethrough
let &t_Te = "\e[29m"        " no strikethrough
let &t_Ce = "\e[4:0m"       " no underline
let &t_Us = "\e[4:2m"       " underdouble
let &t_Cs = "\e[4:3m"       " undercurl
let &t_ds = "\e[4:4m"       " underdotted
let &t_Ds = "\e[4:5m"       " underdashed
let &t_AU = "\e[58:5:%dm"   " underline color ANSI, set by :help ctermul
let &t_8u = "\e[58:2:%lu:%lu:%lum"  " underline color RGB

let &t_8f = "\e[38:2:%lu:%lu:%lum"  " set foreground color RGB
let &t_8b = "\e[48:2:%lu:%lu:%lum"  " set background color RGB

let &t_RF = "\e]10;?\e\\"   " request terminal foreground color
let &t_RB = "\e]11;?\e\\"   " request terminal background color

" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''

" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"

let &t_RC = "\e[?12$p"      " request terminal cursor blinking
let &t_SH = "\e[%d q"       " set cursor shape
let &t_RS = "\eP$q q\e\\"   " request terminal cursor shape
" let &t_VS = "\e[?12l"       " set cursor normal (no blink)

" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"

" Window title
let &t_ST = "\e[22;2t"      " Set window title
let &t_RT = "\e[23;2t"      " Restore window title

" let &t_vi = "\e[?25l" " cursor invisible
" let &t_ve = "\e[?12l\e[?25h" " cursor visible
let &t_ve = "\e[?25h" " cursor visible
" let &t_vs = "\e[?12h" " cursor very visible (blink)

" Cursor shapes per mode
" See: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
"  1, 2 -> blinking / solid block
"  3, 4 -> blinking / solid underscore
"  5, 6 -> blinking / solid vertical bar
let &t_SI = "\e[5 q" " Start INSERT mode
let &t_SR = "\e[3 q" " Start REPLACE mode
let &t_EI = "\e[1 q" " End INSERT/REPLACE -> NORMAL mode

" Enter and exit termcap mode
" t_te should resets cursor back to default on VIM exit
let &t_ti ..= &t_EI
let &t_te ..= "\e[0 q"

" For GUI check :help guicursor
" NOTE: nvim somehow uses guicursor setting in terminal!
set guicursor+=a:blinkon200

" reset cursor when leaving vim
" NOTE: Should be enough to use &t_te instead of VimLeave autocommand
" autocmd VimLeave * silent !echo -ne "\e[0 q"
autocmd VimLeave * set guicursor=a:hor100

" autocmd VimEnter * silent !echo -ne "\e[1 q"
" autocmd VimEnter * normal! :startinsert :stopinsert

