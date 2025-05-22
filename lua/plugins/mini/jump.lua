vim.keymap.set("", ";", ":", { desc = "Why would you need a semicolon, anyway?" })
vim.keymap.set("", ":", ",", { desc = "Oh, so that's why", remap = true })

return {
  mappings = {
    repeat_jump = ",",
  },
  delay = {
    idle_stop = 5000,
  },
  silent = true,
}
