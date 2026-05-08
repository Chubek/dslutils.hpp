# Chapter 3 — Pattern Matching

- Clause constructors: `when<Key>(handler)`, `otherwise(handler)`.
- Dispatcher: `match(clauses...)` producing `MatchTable`.
- Supports value keys and `pattern<...>` regex-like keys.

```dot[graph]
digraph G {
  rankdir=TB;
  node [shape=box];
  Input -> Clause1 [label="try when<K1>"];
  Input -> Clause2 [label="try when<K2>"];
  Input -> Fallback [label="miss"];
  Clause1 -> Out;
  Clause2 -> Out;
  Fallback -> Out;
}
```
