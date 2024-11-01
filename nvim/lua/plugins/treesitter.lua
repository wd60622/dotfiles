-- Define a function to get the absolute path to the query file
local function get_query_path()
  -- Get the current Neovim config directory (relative path)
  local config_dir = vim.fn.stdpath("config")

  -- Concatenate with the relative path to your Treesitter query file
  local query_path = config_dir .. "/after/queries/python/python_docstrings.scm"

  -- Return the expanded full path
  return vim.fn.expand(query_path)
end

-- Define custom fold functions using Treesitter
local function process_docstrings(action)
  local bufnr = vim.api.nvim_get_current_buf()
  local query = vim.treesitter.query.parse(
    "python",
    vim.fn.join(vim.fn.readfile(get_query_path()), "\n")
  )
  local parser = vim.treesitter.get_parser(bufnr, "python")
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
    if query.captures[id] == "comment" then
      local start_line, _, end_line, _ = node:range()
      vim.cmd(start_line + 1 .. "," .. end_line + 1 .. action)
    end
  end
end

local function fold_docstrings()
  process_docstrings("fold")
end

local function unfold_docstrings()
  process_docstrings("foldopen")
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      -- Create Neovim commands to fold/unfold docstrings
      vim.api.nvim_create_user_command("FoldDocstrings", fold_docstrings, {})
      vim.api.nvim_create_user_command(
        "UnfoldDocstrings",
        unfold_docstrings,
        {}
      )

      -- Autocmd to run FoldDocstrings when entering a Python file
      local fold_docstrings_group =
        vim.api.nvim_create_augroup("FoldDocstringGroup", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.cmd("FoldDocstrings")
        end,
        group = fold_docstrings_group,
      })

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        refactor = {
          highlight_definitions = {
            enable = true,
          },
        },
        textobjects = {
          -- swap = {
          --     enable = true,
          --     swap_next = {
          --         ["<leader>a"] = "@parameter.inner",
          --     },
          --     swap_previous = {
          --         ["<leader>A"] = "@parameter.inner",
          --     },
          -- },
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
            },
          },
        },
      })
    end,
  },
}
