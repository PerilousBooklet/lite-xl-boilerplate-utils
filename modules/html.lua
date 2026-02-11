-- mod-version:3
local boilerplate_utils = require 'plugins.boilerplate_utils'


-- __sss__ is the tag to be replaced with the header name
local file_fill_base = [[
<!DOCTYPE html>
<html>
  
  <head>
    <title></title>
  </head>
  
  <body>
    
    
    
  </body>
  
</html>
]]


boilerplate_utils.add_module() {
  name = "HTML", 
  desc = "",
  file_extensions = {
    ".h"
  },
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
