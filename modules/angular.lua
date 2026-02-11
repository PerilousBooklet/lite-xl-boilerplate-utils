-- mod-version:3
local core = require "core"
local boilerplate_utils = require 'plugins.boilerplate_utils'


-- use tag to replace component name: __COMPONENT_NAME__
-- TODO: upper-case/lower-case operations depending on where to paste the component name
local content_base_html = [[

]]
local content_base_css = [[

]]
local content_base_ts = [[

]]


boilerplate_utils.add_module() {
  name = "angular",
  desc = "",
  file_extensions = {},
  file_fills = {},
  boilerplate = {},
  wrap = {},
  docs = {},
  components = {
    {
      name = "base",
      path = "",
      content = {
        {
          ["__FILENAME__.html"] = content_base_html,
          -- TODO: get path from treeview contextmenu () or commandview (like when creating a new folder)
          path = ""
        },
        {
          ["__FILENAME__.css"] = content_base_css,
          path = ""
        },
        {
          ["__FILENAME__.ts"] = content_base_ts,
          path = ""
        }
      }
    }
  },
  properties = {}
}
