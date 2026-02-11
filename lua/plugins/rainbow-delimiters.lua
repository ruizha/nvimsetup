return {
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
    config = function(_, opts)
        require('rainbow-delimiters.setup').setup({
            highlight = {
                'RainbowDelimiterBlue',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
                'RainbowDelimiterYellow',
                'RainbowDelimiterOrange',
                'RainbowDelimiterRed',
            },
        })
    end,
}
