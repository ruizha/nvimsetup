local function github_permalink_line_below()
  -- current buffer info
    local file = vim.fn.expand("%")
    local line = vim.fn.line(".") + 1

    -- git root
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not git_root or git_root == "" then
        vim.notify("Not inside a git repo", vim.log.levels.ERROR)
        return
    end

    -- relative file path
    local rel_file = file:gsub("^" .. git_root .. "/", "")

    -- commit hash
    local commit = vim.fn.systemlist("git rev-parse HEAD")[1]

    -- remote URL
    local remote = vim.fn.systemlist("git remote get-url origin")[1]
    if not remote then
        vim.notify("Could not determine git remote", vim.log.levels.ERROR)
        return
    end

    -- normalize SSH → HTTPS
    remote = remote
    :gsub("^git@github.com:", "https://github.com/")
    :gsub("%.git$", "")

    local url = string.format(
        "%s/blob/%s/%s#L%d",
        remote,
        commit,
        rel_file,
        line
    )

    -- copy to clipboard
    vim.fn.setreg("+", url)
    vim.notify("GitHub permalink copied:\n" .. url)
end

vim.api.nvim_create_user_command(
    "GitHubPermalinkBelow",
    github_permalink_line_below,
    {}
)
