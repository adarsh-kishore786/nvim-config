return {
  "Olical/conjure",
  ft = { "racket", "scheme", "clojure", "fennel" }, -- lazy-load by filetype
  init = function()
    vim.g["conjure#filetype#racket"] = "conjure.client.racket.stdio"
  end,
}
