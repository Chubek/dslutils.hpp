# Chapter 2 — Pipeline and Predicate Algebra

- Stage carrier: `PipeStage<F>`.
- Factory: `pipe(f)`.
- Value flow: `value | pipe(f1) | pipe(f2)`.
- Predicate carrier: `Predicate<F>`.
- Boolean composition: `operator&`, `operator|`, `operator!`.
- Predicate factory: `predicate(f)`.

```dot[graph]
digraph G {
  rankdir=LR;
  node [shape=box];
  V0 [label="value"];
  S1 [label="pipe(f1)"];
  S2 [label="pipe(f2)"];
  R [label="result"];
  V0 -> S1 -> S2 -> R;
}
```
