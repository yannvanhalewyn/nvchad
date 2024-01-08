-- Examples:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua

return {
  s("cl", fmt("(js/console.log {})", { i(1) })),
  s("pp", fmt("(clojure.pprint/pprint {})", { i(1) })),
  s("spy", fmt("(sc.api/spy {})", { i(1) })),
  s("letsc", fmt("(sc.api/letsc {} {})", { i(1, "spypoint"), i(2, "body") })),
  s("req", fmt("(require '[{} :as {}])", { i(1, "example.ns"), i(2, "alias")})),
  s("unalias", fmt("(ns-unalias *ns* {})", { i(1, "alias") })),
  s("unmap", fmt("(ns-unmap *ns* {})", { i(1, "symbol") })),
  s(
    "write-edn",
    fmt([[(binding [*print-namespace-maps* false]
  (clojure.pprint/pprint {} (clojure.java.io/writer "{}")))
    ]], {
      i(1, "data"),
      i(2, "data.edn"),
    })
  ),
}
