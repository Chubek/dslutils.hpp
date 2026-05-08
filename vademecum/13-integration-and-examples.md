# Chapter 13 — Integration Patterns

- Parse -> AST -> Rewrite -> Evaluate.
- `Result<T,E>` as semantic/error boundary.
- `Lazy` for deferred heavy state, `MemoizedCallable` for pure subproblems.
- `TaskChain` for post-parse execution pipelines.

```dot[graph]
digraph G {
  rankdir=TB;
  node [shape=box];
  Parse -> AST -> Rewrite -> Eval -> Result -> Tasks;
}
```

- Example anchors: `examples/awk-parser.cpp`, `examples/01-memoization.cpp`, `examples/06-task-pipeline.cpp`.
