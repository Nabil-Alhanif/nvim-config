vim.cmd("com -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod")
