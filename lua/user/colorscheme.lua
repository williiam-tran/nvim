vim.g["codedark_term256"] = 1
vim.cmd([[
try
  fun! s:setTerminalColors()
      let g:terminal_color_0='#171421'
      let g:terminal_color_1='#C0B91C'
      let g:terminal_color_2='#2FD3DE'
      let g:terminal_color_3='#A17550'
      let g:terminal_color_4='#268bd2'
      let g:terminal_color_5='#C7698B'
      let g:terminal_color_6='#2aa198'
      let g:terminal_color_7='#D0CFCC'
      let g:terminal_color_8='#5E5C64'
      let g:terminal_color_9='#C478C8'
      let g:terminal_color_10='#4CBCC3'
      let g:terminal_color_11='#4EC4C8'
      let g:terminal_color_12='#839496'
      let g:terminal_color_13='#61CB8A'
      let g:terminal_color_14='#93a1a1'
      let g:terminal_color_15='#fdf6e3'
  endf
  autocmd Colorscheme * call <sid>setTerminalColors()
  set t_Co=256
  set t_AB=^[[48;5;%dm
  set t_AF=^[[38;5;%dm
  set t_ut=
  let g:codedark_italics = 1
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
