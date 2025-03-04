vim.api.nvim_create_user_command("ReloadAsync", ":Lazy reload async_preview", {})
vim.api.nvim_create_user_command("PreviewAsync", require("async").preview, {})
