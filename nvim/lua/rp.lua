local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local snippets_path = vim.fn.stdpath("config") .. "/snippets/"

-- Define your snippets with custom names
local snippets = {
    { name = "Template: Test Case", file = "template-test-case.cpp" },
    { name = "Function: BFS", file = "function-bfs.cpp" },
    { name = "Function: DFS", file = "function-dfs.cpp" },
    { name = "Function: Print Vector", file = "function-print-vector.cpp" },
    { name = "Logic: Binary Search on Function", file = "logic-binary-search.cpp" },
    { name = "Logic: Sorted Stack (Biggest on Left)", file = "logic-sorted-stack-left.cpp" },
    { name = "Logic: Sorted Stack (Biggest on Right)", file = "logic-sorted-stack-right.cpp" },
    { name = "Template: Test Case Problem", file = "template-test-case.cpp" },
    { name = "Variables: BFS", file = "variables-bfs.cpp" },
    { name = "Variables: Sorted Stack", file = "variables-sorted-stack.cpp" },
    { name = "Template: LCA", file = "lca.cpp" },
}

local function snippet_picker(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Snippets",
        finder = finders.new_table({
            results = snippets,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end,
        }),
        sorter = sorters.get_fuzzy_file(),
        previewer = previewers.new_buffer_previewer({
            define_preview = function(self, entry, _status)
                local filepath = snippets_path .. entry.value.file
                vim.api.nvim_set_option_value("filetype", "cpp", { buf = self.state.bufnr })
                local lines = vim.fn.readfile(filepath)
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
            end,
        }),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                local filepath = snippets_path .. selection.value.file
                local lines = vim.fn.readfile(filepath)
                vim.fn.setreg('"', lines) -- default register
                vim.fn.setreg('+', lines) -- paste register
                actions.close(prompt_bufnr)
                print("copied '" .. selection.value.name .. "' into \"+ and \"\"")
            end)
            return true
        end,
    }):find()
end

-- Optional command
vim.api.nvim_create_user_command("SnippetsPicker", snippet_picker, {})

return {
    snippet_picker = snippet_picker
}
