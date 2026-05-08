# Chapter 14 — Build and Publishing

- Manifest-driven ordering and metadata from `manifest.yaml`.
- `build.rb` targets: `pandoc`, `manpages`, `custom`, `check`.
- Toolchain assumptions: `pandoc`, optional `dot`, optional post-hook.

```dot[graph]
digraph G {
  rankdir=LR;
  node [shape=box];
  M [label="manifest.yaml"];
  B [label="build.rb"];
  T [label="target command"];
  O [label="artifacts"];
  M -> B -> T -> O;
}
```
