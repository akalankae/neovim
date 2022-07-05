-- Configs for clangd_extensions

local clangd_extensions_ok, clangd_extensions = pcall(require, "clangd_extensions")
if not clangd_extensions_ok then
	return
end

clangd_extensions.setup {
	server = {
		-- options to pass nvim-lspconfig
		-- ie. the arguments to require("lspconfig").clangd.setup({})
	},
}
