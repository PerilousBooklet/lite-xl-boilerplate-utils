#!/bin/bash
lpm run --ephemeral --config='
core.reload_module("colors.onedark")
local boilerplate_utils = require "plugins.boilerplate_utils"
boilerplate_utils.load()
' ./ boilerplate_utils onedark
