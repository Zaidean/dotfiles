let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = "B"
let g:buffergator_autoexpand_on_split = 0
let g:buffergator_split_size = 20

noremap <silent> <Leader>b :BuffergatorToggle<cr>
inoremap <silent> <Leader>b <c-o>:BuffergatorToggle<cr>
