return {
  {
    "da-h/AirLatex.vim", -- Plugin name
    -- Plugin setup for AirLatex
    config = function()
      -- Set your login-name and server name
      vim.g.AirLatexUsername =
      -- "b11202015@g.ntu.edu.tw"
      "cookies:s%3Af8IMAzags6T0gNI4OrvHGqpoDa6GzWa3.J3S%2FRDLZCvWl3uD2pVs9oFFmihf26UgWXp0AAPdvouI"
      vim.g.AirLatexDomain = "www.overleaf.com" -- Optional: set server name
      vim.g.AirLatexAllowInsecure = 1           -- Optional: set server name
    end
  }
}
