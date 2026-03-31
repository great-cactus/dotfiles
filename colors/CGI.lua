-- zenbones based my own colorscheme Colorless Green Idea
--
local colors_name = "CGI"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
	palette = util.palette_extend({
		bg = hsluv "#f3f3f3",
		fg = hsluv "#273f3d",
		rose = hsluv "#885782",
		leaf = hsluv "#7f7650",
		wood = hsluv "#523629",
		water = hsluv "#69a6a2",
		blossom = hsluv "#a5689c",
		sky = hsluv "#7ac2bd",
	}, bg)
else
	palette = util.palette_extend({
		bg = hsluv "#282828",
		fg = hsluv "#ebdbb2",
		rose = hsluv "#fb4934",
		leaf = hsluv "#b8bb26",
		wood = hsluv "#fabd2f",
		water = hsluv "#83a598",
		blossom = hsluv "#d3869b",
		sky = hsluv "#83c07c",
	}, bg)
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement { base_specs.Statement, fg = palette.rose },
		Special { fg = palette.water },
		Type { fg = palette.sky, gui = "italic" },
		Folded { bg = "NONE", fg = base_specs.Normal.fg },
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
