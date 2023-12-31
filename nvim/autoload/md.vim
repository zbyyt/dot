" TODO::
" - put in util??
"-- set foldtext=
"-- set foldtext=MyFoldText()
"--"function MyFoldText()
"--"  local line = vim.fn.getline(vim.v.foldstart)
"--"  local sub = vim.fn.substitute(line, "\\v^(\\s*[^ \t]+).+", "\\1...", "")
"--  -- sub = vim.fn.substitute(sub, "substring", "\\=highlight_submatch('Search', sub)", "g")
"  -- return "  \u25BC " .. sub
"--  return sub
"--end

"" TODO: wordcount function
"" wordcount:
"" system("wc -l ", shellescape(expand("%"))) . "l"
 ""    --%b "b" t:" strftime('%d/%m %t')

" Markdown Preview ==========================================
  function! OpenMarkdownPreview() abort
	"chatgpt version is in md.lua
    if exists('s:markdown_job_id') && s:markdown_job_id > 0
      call jobstop(s:markdown_job_id)
      unlet s:markdown_job_id
    endif
    let available_port = system(
      \ "lsof -s tcp:listen -i :40500-40800 | awk -F ' *|:' '{ print $10 }' | sort -n | tail -n1"
      \ ) + 1
    if available_port == 1 | let available_port = 40500 | endif
    let s:markdown_job_id = jobstart('grip ' . shellescape(expand('%:p')) . ' :' . available_port)
    if s:markdown_job_id <= 0 | return | endif
    call system('open http://localhost:' . available_port)
  endfunction

"##########################################
"start table mode from insert mode with __ or ||
function! md#isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

" EQUALISE ################################
function! md#EqualWidth()
	let l:tbn = tabpagenr()
	tabdo set noequalalways equalalways
	exe "tabnext " . l:tbn
endfunction
" WIDE MARGINS ##############################
function! md#WideMargin()
	setlocal number
	setlocal numberwidth=20
endfunction
function! md#WideMarginToggle()
  if &number  == 0
	setlocal number
	setlocal numberwidth=20
  elsmelighte
	setlocal nonumber
  endif
endfunction
"HIDE ALL ############################
function! md#ToggleHiddenAll()
    if !exists("g:hidden_all")
        let g:hidden_all = 0
    endif
	if g:hidden_all  == 0
        let g:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let g:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

function! md#HideAll()
    let g:hidden_all = 1
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
    "call uix#MyTabLineCol()
endfunction
"====================================================
" WriteMode 
" 	will aim to do a 'Goyo' but more minimally and with tabs
"	split window. Assign winfixwidth to stop 1 window from adapting size on
"	next split
"	hide '~' symbols
"
" hide vert boundary
	" :hi VertSplit ctermfg=bg ctermbg=bg guifg=bg guibg=bg
	" alternative to 'fillchars' to hide window boundaries

" ==============================================
" writemode ===================================
function! md#WriteMode()
	setlocal fillchars+=vert:\ 
	vnew "spawns empty pane to far left
	setlocal fillchars+=vert:\ 
	vert botright split "spawns empty to far right
	wincmd h
	vertical resize +30
	setlocal winfixwidth
	wincmd =
	"Limelight
	"highlight EndOfBuffer
		"\ ctermfg=black guifg=black
		"\ ctermbg=black guibg=black
endfunction

function! md#WriteModeOff()
	only
	setlocal fillchars+=vert:\ 
	"highlight EndOfBuffer 
		"\ ctermfg=black guifg=black 
		"\ ctermbg=black guibg=black
	"Limelight!
endfunction

function! md#ToggleWrite()
	if !exists("t:write_mode")
        let t:write_mode = 0
    	endif

	if t:write_mode  == 0
		let t:write_mode = 1
		call md#WriteMode()
	elseif t:write_mode == 1
		let t:write_mode = 0
		call md#WriteModeOff()
	endif
endfunction

" ###################################################
" GOYO #################################################
function! md#Goyo_enter()
	autocmd! goyo TabLeave
	if executable('tmux') && strlen($TMUX)
    		silent !tmux set status off
    		silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  	endif
	"silent Limelight
endfunction
function! md#Goyo_leave()
	if executable('tmux') && strlen($TMUX)
    		silent !tmux set status on
    		silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  	endif
	silent call md#ToggleHiddenAll()
	silent syntax on
	" silent Limelight!
endfunction

