local fqbn = vim.g.arduino_fqbn or vim.env.ARDUINO_FQBN or "esp32:esp32:esp32s2"

return {
	cmd = {
		"arduino-language-server",
		"-cli",
		"arduino-cli",
		"-cli-config",
		vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
		"-fqbn",
		fqbn,
		"-clangd",
		"clangd",
	},
}
