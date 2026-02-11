-- mod-version:3
local boilerplate_utils = require 'plugins.boilerplate_utils'


-- __sss__ is the tag to be replaced with the header name
local file_fill_header = [[
#ifndef __sss__
#define __sss__



#endif
]]


boilerplate_utils.add_module() {
  name = "c", 
  desc = "",
  file_extensions = {
    ".h"
  },
  file_fills = {
    {
      type = "header",
      content = file_fill_header
    }
  },
  boilerplate = {},
  wrap = {},
  docs = {},
  components = {},
  properties = {}
}
