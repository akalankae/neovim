--> Configs for nvim-tree explorer

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
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

require("nvim-tree").setup{
  sort_by = "case_sensitive",
  }
