return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- enable fuzzy matching
            override_generic_sorter = true, -- use fzf for generic sorter
            override_file_sorter = true,    -- use fzf for file sorter (find_files)
            case_mode = "smart_case",       -- "ignore_case" | "respect_case" | "smart_case"
        }
    },
    opts = {},
}
