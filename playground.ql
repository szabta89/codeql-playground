pragma[noinline]
query string knowsRec(string p) {
  exists(string o | talksTo(o, p) and hasSecret(o, result))
  or
  exists(string o | talksTo(o, p) and result = knowsRec(o))
}

pragma[noinline]
query string knowsNonRec(string p) {
  exists(string a | talksTo(a, p) and hasSecret(a, result))
  or
  exists(string a, string b | talksTo(a, b) and talksTo(b, p) and hasSecret(a, result))
  or
  exists(string a, string b, string c |
    talksTo(a, b) and talksTo(b, c) and talksTo(c, p) and hasSecret(a, result)
  )
}

pragma[noinline]
predicate talksTo(string a, string b) {
  exists(@externalDataElement e |
    externalData(e, _, 0, "talksTo") and externalData(e, _, 1, a) and externalData(e, _, 2, b)
  )
}

pragma[noinline]
predicate hasSecret(string p, string s) {
  exists(@externalDataElement e |
    externalData(e, _, 0, "secret") and externalData(e, _, 1, p) and externalData(e, _, 2, s)
  )
}
