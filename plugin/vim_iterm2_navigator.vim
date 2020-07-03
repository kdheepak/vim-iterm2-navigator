if exists("g:loaded_vim_iterm2_navigator") | finish | endif

let s:save_cpo = &cpoptions
set cpoptions&vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits: wincmd k' | echohl None
  endtry
endfunction

nnoremap <silent> <c-h> :VimiTerm2NavigateLeft<cr>
nnoremap <silent> <c-j> :VimiTerm2NavigateDown<cr>
nnoremap <silent> <c-k> :VimiTerm2NavigateUp<cr>
nnoremap <silent> <c-l> :VimiTerm2NavigateRight<cr>

command! VimiTerm2NavigateLeft     call s:VimiTerm2AwareNavigate('h')
command! VimiTerm2NavigateDown     call s:VimiTerm2AwareNavigate('j')
command! VimiTerm2NavigateUp       call s:VimiTerm2AwareNavigate('k')
command! VimiTerm2NavigateRight    call s:VimiTerm2AwareNavigate('l')

function! s:VimiTerm2Command(direction)
    if a:direction == 'h'
        keycode = '123'
    elseif a:direction == 'l'
        keycode = 124
    elseif a:direction == 'j'
        keycode = 125
    elseif a:direction == 'k'
        keycode = 126
    endif
    cmd = 'osascript -e "tell application \"System Events\" to key code ' + ' using {command down, option down}"'
    return system(cmd)
endfunction

function! s:VimiTerm2AwareNavigate(direction)
  let nr = winnr()
  s:VimNavigate(direction)
  let at_window_edge = (nr == winnr())
  if at_window_edge
    silent call s:VimiTerm2Command(direction)
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let &cpoptions = s:save_cpo
unlet s:save_cpo

let g:loaded_vim_iterm2_navigator = 1
