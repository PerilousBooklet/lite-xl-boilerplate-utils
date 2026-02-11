-- mod-version:3
local boilerplate_utils = require 'plugins.boilerplate_utils'


-- sss is the tag to be replaced with the PHP base tag

local file_fill_base = [[
<?php
  
  
  
?>
]]


boilerplate_utils.add_module() {
  name = "", 
  desc = "",
  file_extensions = { ".php" },
  file_fills = {
    {
      type = "base",
      content = file_fill_base
    }
  },
  boilerplate = {},
  wrap = {},
  docs = {},
  components = {},
  properties = {}
}
