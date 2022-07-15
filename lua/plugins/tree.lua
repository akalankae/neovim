-- Configs for nvim-tree plugin for file system navigation

local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	error("Failed to import nvim-tree", 2)
	return
end

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local function collapse_all()
	require("nvim-tree.actions.collapse-all").fn()
end

local function edit_or_open()
	--> open as vsplit on current node
	local action = "edit"
	local node = lib.get_node_at_cursor()

	--> just copy what is done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.open-file").fn(action, node.link_to)
		view.close() --> if file was opened close the tree
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.open-file").fn(action, node.absolute_path)
		view.close()
	end
end

local function vsplit_preview()
	--> open as vsplit on current node
	local action = "vsplit"
	local node = lib.get_node_at_cursor()

	--> just copy what is done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.open-file").fn(action, node.link_to)
		view.close() --> if file was opened close the tree
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.open-file").fn(action, node.absolute_path)
	end

	--> finally refocus on tree if focus was lost
	view.focus()
end
-- Others are default mappings on github
-- Part are taken from github wiki page for nvim-tree
-- source: https://github.com/kyazdani42/nvim-tree.lua/wiki/h,-j,-k,-l--style-navigation-and-editing
nvim_tree.setup {
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "u", action = "dir_up" },
        --> l: if a folder open node, if a file open it and close the tree
        { key = "l", action = "edit", action_cb = edit_or_open },
        --> L: if a folder open node, if a file open in a vertical split, but keep focus on tree
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        --> h: collpase current containing folder
        { key = "h", action = "close_node" },
        --> H: collpase tree { This defaults to W }
        -- { key = "H", action = "collapse_all", action_cb = collapse_all },
      },
    },
  },
  renderer = { group_empty = true },
  filters = { dotfiles = true },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
}
