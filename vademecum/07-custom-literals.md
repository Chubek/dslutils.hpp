# Chapter 7 — Custom Literals

- Entry constructor: `lit<"_suffix">(handler)`.
- Registry constructor: `literal_set(entries...)` -> `LiteralSet`.
- Parse API: `parse_literal(input)` when `Derived::literals` exists.

```dot[graph]
digraph G {
  rankdir=LR;
  node [shape=box];
  S [label=""3.5_km""];
  Split [label="numeric/suffix split"];
  Scan [label="LiteralSet scan"];
  H [label="handler"];
  R [label="long double"];
  S -> Split -> Scan -> H -> R;
}
```
