# Chapter 11 — Parser DSL and Semantics

- Choice: `p1 | p2`.
- Sequence: `p1 & p2`.
- Repetition: `*p`.
- Optional: `optional(p)`.
- Semantic metadata: `ParserStage`.
- Handler registration: `production<"id">(fn)`.
- Action pass: `parse_with_action(...)`.

```dot[graph]
digraph G {
  rankdir=LR;
  node [shape=box];
  In [label="ParsecInput"];
  Comb [label="Combinators"];
  Stage [label="ParserStage"];
  Sem [label="semantics map"];
  Act [label="action fn"];
  In -> Comb -> Stage -> Act;
  Sem -> Act;
}
```
