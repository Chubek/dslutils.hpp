# Chapter 9 — Monadic Optional and Result

- Optional monads: `Maybe<T>`, `map`, `flat_map`, `filter`, `or_else`.
- Result monad: `Result<T,E>` with `map`, `map_err`, `and_then`.
- Constructors: `from_ok`, `from_err`, wrappers `Ok`, `Err`.

```dot[graph]
digraph G {
  rankdir=TB;
  node [shape=box];
  R0 [label="Result<T,E>"];
  OK [label="map/and_then"];
  ER [label="map_err"];
  R1 [label="Result<U,F>"];
  R0 -> OK -> R1;
  R0 -> ER -> R1;
}
```
