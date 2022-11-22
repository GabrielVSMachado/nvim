local ok, cmpConfig = pcall(require, "cmp")
if not ok then return end

local highlights_lspkind = {
  PmenuSel = { bg = "#282C34", fg = "NONE" },
  Pmenu = { bg = "#22252A", fg = "#C5CDD9" },

  CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
  CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
  CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
  CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },

  CmpItemKindField = { fg = "#000000", bg = "#B5585F" },
  CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

  CmpItemKindText = { fg = "#000000", bg = "#9FBD73" },
  CmpItemKindEnum = { fg = "#000000", bg = "#9FBD73" },
  CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

  CmpItemKindConstant = { fg = "#000000", bg = "#D4BB6C" },
  CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

  CmpItemKindFunction = { fg = "#000000", bg = "#A377BF" },
  CmpItemKindStruct = { fg = "#000000", bg = "#A377BF" },
  CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

  CmpItemKindVariable = { fg = "#000000", bg = "#7E8294" },
  CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

  CmpItemKindUnit = { fg = "#000000", bg = "#D4A959" },
  CmpItemKindSnippet = { fg = "#000000", bg = "#D4A959" },
  CmpItemKindFolder = { fg = "#000000", bg = "#D4A959" },

  CmpItemKindMethod = { fg = "#000000", bg = "#6C8ED4" },
  CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

  CmpItemKindInterface = { fg = "#000000", bg = "#58B5A8" },
  CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
}

for key, value in pairs(highlights_lspkind) do
  local command = "highlight! " .. key
  command = command .. " guibg=" .. value['bg'] .. " guifg=" .. value['fg']
  command = command .. " gui=" .. (value['fmt'] or "NONE")
  vim.cmd(command)
end

cmpConfig.setup {

  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0
    }
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)

      local ok_, lspkind = pcall(require, "lspkind")
      if not ok_ then
        vim.notify("Couldn't load lspkind!!!")
        return
      end

      local kind = lspkind.cmp_format(
        { mode = "symbol_text", maxwidth = 50 }
      )(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = ' (' .. (strings[2] or "") .. ')'

      return kind
    end
  },

  snippet = {
    expand = function(args)
      require "luasnip".lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-p>"] = cmpConfig.mapping.select_prev_item(),
    ["<C-n>"] = cmpConfig.mapping.select_next_item(),
    ["<C-d>"] = cmpConfig.mapping.scroll_docs(-4),
    ["<C-f>"] = cmpConfig.mapping.scroll_docs(4),
    ["<C-Space>"] = cmpConfig.mapping.complete(),
    ["<C-e>"] = cmpConfig.mapping.close(),
    ["<CR>"] = cmpConfig.mapping.confirm {
      behavior = cmpConfig.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = cmpConfig.mapping(function(fallback)
      if cmpConfig.visible() then
        cmpConfig.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>luasnip-expand-or-jump",
            true,
            true,
            true
          ),
          ""
        )
      else
        fallback()
      end
    end, { "i", "s", }),
    ["<S-Tab>"] = cmpConfig.mapping(function(fallback)
      if cmpConfig.visible() then
        cmpConfig.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>luasnip-jump-prev", true, true, true
          ),
          ""
        )
      else
        fallback()
      end
    end, { "i", "s", }),
  },

  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" }
  },
}
