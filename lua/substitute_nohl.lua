local cmdline_content = ''

vim.api.nvim_create_autocmd('CmdLineEnter', {
    group = vim.api.nvim_create_augroup('SubstituteTrackEnter', {clear = true}),
    pattern = ':',
    callback = function()
        cmdline_content = ''
    end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
    group = vim.api.nvim_create_augroup('SubstituteNohlOnLeave', {clear = true}),
    pattern = ':',
    callback = function()
        cmdline_content = vim.fn.getcmdline()

        if cmdline_content:match("^'<,'>s/") or
           cmdline_content:match("^'<,'>S") or
           cmdline_content:match("^'<,'>substitute/") or
           cmdline_content:match("^%%s/") or
           cmdline_content:match("^s/") or
           cmdline_content:match("^%d+,%d+s/") or  -- 行番号範囲指定
           cmdline_content:match("^%.,%$s/") or    -- 現在行から最終行
           cmdline_content:match("^%.,%%s/") then  -- その他の範囲指定
            vim.defer_fn(function()
                vim.cmd('noh')
            end, 0)
        end
    end,
})
