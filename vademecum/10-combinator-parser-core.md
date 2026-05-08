# Chapter 10 — Combinator Parser Core

- Input carrier: `ParsecInput { source, pos }`.
- Primitive ops: `peek`, `consume`, `eof`, `get_span`.
- Parser type: `Parser<T>` wrapping `ExpectedResult<T>(ParsecInput&)`.
- Constructor: `parser(fn)`.

```dot[graph]
digraph G {
  rankdir=LR;
  node [shape=box];
  Src [label="source+cursor"];
  P [label="Parser<T>"];
  Res [label="ExpectedResult<T>"];
  Src -> P -> Res;
}
```
