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

command! VimiTerm2NavigateLeft     call VimiTerm2AwareNavigate('h')
command! VimiTerm2NavigateDown     call VimiTerm2AwareNavigate('j')
command! VimiTerm2NavigateUp       call VimiTerm2AwareNavigate('k')
command! VimiTerm2NavigateRight    call VimiTerm2AwareNavigate('l')

function! VimiTerm2Command(direction)
    if a:direction == 'h'
        let keycode = '123'
    elseif a:direction == 'l'
        let keycode = '124'
    elseif a:direction == 'j'
        let keycode = '125'
    elseif a:direction == 'k'
        let keycode = '126'
    endif
    silent call system('osascript -e "tell application \"System Events\" to key code ' . keycode . ' using {command down, option down}"')
endfunction

function! VimiTerm2AwareNavigate(direction)
  let nr = winnr()
  call s:VimNavigate(a:direction)
  let at_window_edge = (nr == winnr())
  if at_window_edge
    silent call VimiTerm2Command(a:direction)
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let &cpoptions = s:save_cpo
unlet s:save_cpo

let g:loaded_vim_iterm2_navigator = 1
