# ⚡️ Apostrofree - Free your apostrophes, free your potential 

![](https://github.com/tjmblake/apostrofree/blob/main/freedom-dog.webp)

## Protect the Buffer 🛡️

A wise man once said, consistency is key.

When dealing with copy, pasted from Windows, you'll find U+2019 used 
instead of U+0027. 

This package helps you spot and replace those rogue U+2019 chars.

## Usage 🛠️

Install with package manager. 

### Default Bindings 🔑

```lua
'<Leader>apos' => replace all U+2019 chars with U+0027
```

### Setup Diagnostics 📡

```lua
local apos = require('apostrofree')

vim.api.nvim_create_autocmd({ 'BufWritePost', "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		apos.see_thee_apostrofree()
	end
})
```
