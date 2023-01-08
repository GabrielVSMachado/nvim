vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost pluginList.lua source <afile> | PackerCompile
  augroup end
]])
