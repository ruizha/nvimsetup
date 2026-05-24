vim.api.nvim_create_user_command("CodexTmux", function(opts)
    local name = opts.args ~= "" and opts.args or "main"
    local qname = vim.fn.shellescape(name)

    local exists = (vim.fn.system("tmux has-session -t " .. qname .. " 2>/dev/null; echo $?")):match("%d+")
    if exists == "0" then
      vim.cmd("silent !tmux attach -t " .. qname)
    else
      -- create new session, run `codex`, then attach
      vim.cmd("silent !tmux new-session -d -s " .. qname)
      vim.cmd("silent !tmux send-keys -t " .. qname .. " codex C-m")
      vim.cmd("silent !tmux attach -t " .. qname)
    end
end, {
    nargs = "?",
})

vim.keymap.set("n", "<leader>cdx", "<cmd>CodexTmux codex<CR>", {
    desc = "start tmux codex session",
    silent = true,
})
