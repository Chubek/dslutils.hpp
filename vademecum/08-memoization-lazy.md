# Chapter 8 — Memoization and Lazy

- `MemoizedCallable<Key, Value, Fn>` caches via `std::unordered_map`.
- Constructor helper: `memoize<Key, Value>(fn)`.
- Invalidation: `clear_cache()`.
- `Lazy<T>` defers single computation and caches the value.

```dot[graph]
digraph G {
  rankdir=LR;
  node [shape=box];
  Call -> Lookup;
  Lookup -> Hit [label="cached"];
  Lookup -> Compute [label="miss"];
  Compute -> Store -> Hit;
}
```
