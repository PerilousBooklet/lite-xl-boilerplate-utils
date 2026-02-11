-- mod-version:3
local core = require "core"
local common = require "core.common"
local command = require "core.command"
local config = require "core.config"
local TreeView = require "plugins.treeview"
local DocView = require "core.docview"

local fsutils = require "plugins.boilerplate_utils.fsutils"


-------
-- ? --
-------

local boilerplate_utils = {}
local modules = {}
local treeview_menu = TreeView.contextmenu
-- TODO: how does it work?
local docview_menu_found, docview_menu = pcall(require, "plugins.contextmenu")


---------------------------
-- Configuration Options --
---------------------------

config.plugins.boilerplate_utils = common.merge({
  -- ?
}, config.plugins.boilerplate_utils)


-----------------------
-- Utility functions --
-----------------------

-- ?
local function get_active_docview()
  local av = core.active_view
  if getmetatable(av) == DocView and av.doc and av.doc.filename then
    return av
  end
  return nil
end


------------------
-- Data Storage --
------------------

-- ?
local function matches_any(filename, patterns)
	for _, pattern in ipairs(patterns) do
		if string.find(filename, pattern) then
			return true
		end
	end
end

-- Return the first matching module
local function get_module(module_name)
	for _,v in pairs(modules) do
		if module_name == v.name then
			core.log("Found module: " .. module_name)
			return v
		end
	end
	core.log("Module : " .. module_name .. " is missing.")
	return nil
end

-- Add a module table to the modules table
function boilerplate_utils.add_module()
  return function(m)
    table.insert(modules, m)
  end
end

-- Get list of template files
local function parse_list()
	local list = system.list_dir(USERDIR .. "/plugins/boilerplate_utils/modules")
  local list_matched = {}
  local temp_string = ""
  for k, v in pairs(list) do
    temp_string = string.gsub(list[k], ".lua", "")
    table.insert(list_matched, temp_string)
  end
  return list_matched
end

-- Load modules
function boilerplate_utils.load()
  -- Get modules' filenames
  local modules_list = parse_list()
  -- Load module files
  for _, v in ipairs(modules_list) do
    require("plugins.boilerplate_utils.modules." .. v)
    core.log("Loaded boilerplate module: " .. v)
  end
end


--------------------------
-- Generation Functions --
--------------------------

local function test()
  core.log(common.serialize(TreeView.hovered_item))
  core.log(common.serialize(TreeView.hovered_item.abs_filename))
end

local function test_in_doc()
  local current_docview = get_active_docview()
  -- ?
end

local function test_global()
  core.log("TEST GLOBAL")
end

-- NOTE: returns table on first match
local function select_module(file_extension)
  for _, module in ipairs(modules) do
  	for _, extension in ipairs(module.file_extensions) do
  	  if extension == file_extension then
  	    return common.serialize(module)
  	  end
  	end
  end
end

-- Automatic FILE FILL of New Named Doc
local old_open_doc = core.open_doc -- Get old function content
-- Extend old function
function core.open_doc(filename, ...)
  -- New file check (to avoid writing in the file every time it's opened)
  local file_exists = system.get_file_info(filename) ~= nil
  -- Inherit old function content
  local doc = old_open_doc(filename, ...)
  -- New logic
  -- TODO: draw commandview to select file fill type
  local file_extension = string.match(filename, "%.%a+$")
  local selected_module = select_module(file_extension)
  -- FIX: returned module is missing pieces ?
  print(selected_module)
  -- WIP: get package path for new Java file, set it and write it (get the pkg path root from the properties table)
  if doc.filename == filename and not file_exists then
  	if string.find(doc.filename, file_extension) then
      -- FIX: ?
      for _, file_fill in ipairs(selected_module.file_fills) do
        doc:insert(1, 1, file_fill)
      end
    end
  end
  -- Return expected output (See old function)
  return doc
end

-- TODO: add file_fill func. to New File from treeview context menu

-- NOTE: requires interaction with `lsp` to get the symbols data
-- Writes text into existing file starting from given position in the doc (specified in module)
-- (anchor: es. Java: line containing '}' + 1 line above, add one empty line above generated text)
-- (code: es. Java: getter/setter boilerplate code)
local function write_text_into_doc(anchor, text)
  -- TODO: write starting from given anchor: (line,col)
  -- EXAMPLE: selected symbol line (es. javadoc comment for Java class/method/attribute)
  -- EXAMPLE: contructors/getters/setters/... starting from one empty line above last line of current doc (1 indentation inside class)
  -- TODO: get selection and replace with wrapped selection
  -- EXAMPLE: wrap selected block of code with try-catch
end

-- maybe write_text_into_doc() is enough ?
local function wrap_text(anchor, text, wrap_line_top, wrap_line_bottom)
	-- ?
end

local function create_folder(folder_path, folder_name)
  -- copy from lite-lx-ptm
end

local function create_and_fill_file(file_path, file_name, file_content)
  -- copy from lite-lx-ptm
end


-----------
-- Logic --
-----------

-- TODO: add context menu items for each action (look at the treeview-extender plugin)
-- TODO: es. Java: use last } as anchor and paste new content 2 lines above it (check that above paste position there are 2 empty lines)
-- TODO: check current file extension (commands must have context: current doc) and show options (defined in module) with commandview
--       (es. getters, setters, getters and setters, toString, ...)
--       1. override command: New Named Doc -> add file extension check -> show file-type commandview
local function generate_boilerplate()
	-- TODO: get current doc's file extension
	-- TODO: determine which module table to use
	-- TODO: call generate_text_in_file()
	-- TODO: open commandview...
end

-- TODO: Wrap code selection (context: current doc, command),
--       wrap selected code (es. try-catch-finally, ...),
--       add items to Doc context menu
--       1. get selection
--       2. add lines, add one indent to selected code
--       3. replace selection
local function wrap_code_selection()
	-- TODO: open commandview...
	-- TODO: temporary base logic
	
end

-- TODO: command to auto-generate doc comments for selected symbol
-- TODO: command to auto-generate doc comments for all symbols in current doc (?)
-- TODO: command to auto-generate doc comments for all project file (es. all .java files in project folder) (?)
--       1. get position of start of line above selection
--       2. insert text at that position plus empty line above
-- TODO: check that symbol doesn't already have doc comments above
local function generate_doc_comment()
	-- TODO: get selected symbol from lsp
	-- TODO: write doc comment
end

local function generate_doc_comments()
	-- TODO: get list of current doc symbols
	-- TODO: call generate_doc_comment for each of them
end

-- NOTE: user needs to provide only the details: es. name and attributes for Entity class
local function generate_component()
  -- TODO: after clicking on treview item, open commandview to input the component's details (name, ...)
  -- TODO: get destination path and component details
  -- TODO: create folder ?
  -- TODO: create and fill files
end


------------------
-- Context Menu --
------------------

-- This adds a new separator in the treeview context menu
treeview_menu:register(
  function()
    return TreeView.hovered_item and (fsutils.is_dir(TreeView.hovered_item.abs_filename) ~= true or TreeView.hovered_item.abs_filename ~= fsutils.project_dir())
  end,
  { 
    treeview_menu.DIVIDER
  }
)

-- ?
treeview_menu:register(
  function()
    return TreeView.hovered_item and fsutils.is_dir(TreeView.hovered_item.abs_filename) ~= true
  end,
  {
    {
      text = "Test",
      command = "boilerplate_utils:test-global"
    }
  }
)

-- This adds a new separator to a docview context menu
-- if docview_menu_found then
--   docview_menu:register(
--     -- FIX: all context menus are overridden
--     -- NOTE: cause: context is set to global
--     nil,
--     {
--       docview_menu.DIVIDER
--     }
--   )
-- end


--------------
-- Commands --
--------------

-- NOTE: the plugin gets called from here...

-- Context: global
command.add(nil,{ 
  ["boilerplate_utils:test-global"] = test_global
})

-- Context: current docview
command.add("core.docview", {
  -- Test
  ["boilerplate_utils:test-in-doc"] = test_in_doc,
  -- Final
  ["boilerplate_utils:generate-boilerplate"] = generate_boilerplate,
  ["boilerplate_utils:wrap-code-selection"] = wrap_code_selection,
  ["boilerplate_utils:generate-doc-comment"] = generate_doc_comment,
  ["boilerplate_utils:generate-doc-comments"] = generate_doc_comments
})

-- Context: treeview's context menu
command.add(
  function()
    return TreeView.hovered_item and fsutils.is_dir(TreeView.hovered_item.abs_filename) ~= true
  end, {
    -- Test
    ["boilerplate_utils:test"] = test,
    -- Final
    ["boilerplate_utils:generate_component"] = generate_component
  }
)


-------
-- ? --
-------

return boilerplate_utils
