# Chapter 12 — Task Pipeline

- State: `TaskState`.
- Unit: `Task`.
- Sequence: `TaskChain`.
- Policy: `TaskPolicy::{StopOnError, ContinueOnError}`.
- Composition: `Task | Task`, `TaskChain | Task`.
- Execution: `run(state, chain, ...)`, `suspend(state)`, `upon(state, event, task)`.

```dot[graph]
digraph G {
  rankdir=LR;
  node [shape=box];
  S [label="TaskState"];
  T1 [label="Task1"];
  T2 [label="Task2"];
  T3 [label="Task3"];
  S -> T1; S -> T2; S -> T3;
  T1 -> T2 -> T3;
}
```
