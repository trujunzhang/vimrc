" Author: Justin Searls - https://github.com/searls
" Description: Fix Ruby files with StandardRB.

call ale#Set('ruby_standardrb_options', '')
call ale#Set('ruby_standardrb_executable', 'standardrb')

function! ale#fixers#standardrb#GetCommand(buffer) abort
    let l:executable = ale#Var(a:buffer, 'ruby_standardrb_executable')
    let l:config = ale#path#FindNearestFile(a:buffer, '.standard.yml')
    let l:options = ale#Var(a:buffer, 'ruby_standardrb_options')

    return ale#handlers#ruby#EscapeExecutable(l:executable, 'standardrb')
    \   . (!empty(l:config) ? ' --config ' . ale#Escape(l:config) : '')
    \   . (!empty(l:options) ? ' ' . l:options : '')
    \   . ' --fix --force-exclusion %t'
endfunction

function! ale#fixers#standardrb#Fix(buffer) abort
    return {
    \   'command': ale#fixers#standardrb#GetCommand(a:buffer),
    \   'read_temporary_file': 1,
    \}
endfunction
