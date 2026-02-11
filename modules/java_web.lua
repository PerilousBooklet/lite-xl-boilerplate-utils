-- mod-version:3
local boilerplate_utils = require 'plugins.boilerplate_utils'


-- INPUT
-- How to input the attribute names and types: 
-- inside a dedicated commandview: es. String firstName|String lastName|boolean isValid
-- use a few simple lua patterns to extract the items from the commandview output

local attr = [[
private __INPUT__
]]


-- TODO: get current cursor position in Doc to be used as anchor
local anchor_cursor = {
  "?"
}


boilerplate_utils.add_module() {
  name = "java", 
  desc = "",
  file_extensions = { ".java" },
  file_fills = {},
  boilerplate = {
    -- Field attributes for an Entity class (when using ORMs)
    {
      type = "",
      anchor = { anchor_cursor, 0 },
      content = attr
    }
    -- TODO: DAO/DTO class (?)
  },
  wrap = {},
  docs = {},
  components = {},
  properties = {}
}
