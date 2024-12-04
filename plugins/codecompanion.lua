return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    config = function()
      require("codecompanion").setup({
        display = {
          chat = {
            render_headers = false,
          },
          action_palette = {
            provider = "telescope", -- Set to "telescope" or "mini_pick"
          },
        },
        strategies = {
          chat = {
            adapter = "gemini",
          },
          inline = {
            adapter = "gemini",
          },
        },
        adapters = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "cmd:cat $HOME/Private/Gemini_API.txt"
              },
            })
          end,
        },
      })
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>za", "<cmd>CodeCompanionActions<cr>",
        { desc = "CodeCompanion Telescope integrated UI n-mode" })
      keymap.set("v", "<leader>za", "<cmd>CodeCompanionActions<cr>",
        { desc = "CodeCompanion Telescope integrated UI v-mode" })
    end,
    cmd = { "CodeCompanionActions", "Telescope codecompanion" }, -- Lazy-load commands
  }
}
