local ls = require("luasnip")
local snippet = ls.snippet
local textn = ls.text_node
local insertn = ls.insert_node
local snippetn = ls.snippet_node
local dynamicn = ls.dynamic_node
local functionn = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(args, parent)
	if (#parent.snippet.env.LS_SELECT_RAW > 0) then
		return snippetn(nil, insertn(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return snippetn(nil, insertn(1))
	end
end

local in_mathzone = function()
	-- The `in_mathzone` function requires the VimTeX plugin
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
	snippet(
		{ trig = "env" },
		fmta(
			[[
				\begin{<>}
				<>
				\end{<>}
			]],
			{
				insertn(1),
				insertn(2),
				rep(1),
			}
		)
	),

	snippet(
		{ trig = "tii", snippetType = "autosnippet" },
		fmta("\\textit{<>}",
			{
				dynamicn(1, get_visual),
			}
		)
	),

	snippet(
		{ trig = "([^%w])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>$<>$",
			{
				functionn(function(_, snip) return snip.captures[1] end),
				dynamicn(1, get_visual),
			}
		)
	),

	snippet(
		{ trig = "^([%s]*)mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>$<>$",
			{
				functionn(function(_, snip) return snip.captures[1] end),
				dynamicn(1, get_visual),
			}
		)
	),

	snippet(
		{ trig = "dm", snippetType = "autosnippet", condition = line_begin },
		fmta(
			[[
				$$
				<>
				$$
			]],
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "equ", snippetType = "autosnippet", condition = line_begin },
		fmta(
			[[
				\begin{equation}\label{<>}
				<>
				\end{equation}
			]],
			{
				insertn(1),
				insertn(2),
			}
		)
	),

	snippet(
		{ trig = "SSE", snippetType = "autosnippet", condition = line_begin },
		fmta("\\section{<>}",
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "SSS", snippetType = "autosnippet", condition = line_begin },
		fmta("\\subsection{<>}",
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "SS2", snippetType = "autosnippet", condition = line_begin },
		fmta("\\subsubsection{<>}",
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "SPG", snippetType = "autosnippet", condition = line_begin },
		fmta("\\paragraph{<>}",
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "ff", snippetType = "autosnippet", condition = in_mathzone },
		fmta("\\frac{<>}{<>}",
			{
				insertn(1),
				insertn(2),
			}
		)
	),

	snippet(
		{ trig = "sr", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone },
		textn("^{2}")
	),

	snippet(
		{ trig = "cb", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone },
		textn("^{3}")
	),

	snippet(
		{ trig = "rs", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone },
		fmta("^{<>}",
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "sq", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone },
		fmta("\\sqrt{<>}",
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "_", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone },
		fmta("_{<>}",
			{
				insertn(1),
			}
		)
	),

	snippet(
		{ trig = "·", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone },
		textn("\\cdot")
	),
}
