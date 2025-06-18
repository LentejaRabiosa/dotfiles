local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
    s("beg",
        t("\\begin{"),
        i(1, "environment"),
        t("}\n\t"),
        i(2, "content"),
        t("\n\\end{"),
        rep(1),
        t("}")
    ),

    s("frac", fmt("\\frac{{{}}}{{{}}}", {
        i(1, "term 1"), i(2, "term 2")
    })),

    s("mk", fmt("${}$", {
        i(1, "math")
    })),

    s("dm", fmt("$$\n{}\n$$", {
        i(1, "math")
    })),
}
