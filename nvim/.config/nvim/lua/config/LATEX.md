# LaTeX in Neovim

Stack: [vimtex](https://github.com/lervag/vimtex) (compiling, viewing, navigation,
text objects) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip) (snippet engine) +
[luasnip-latex-snippets.nvim](https://github.com/evesdropper/luasnip-latex-snippets.nvim)
(the actual snippet pack, colloquially "LaTeX Suite") + blink.cmp (completion menu,
pulling suggestions from LuaSnip). Config lives in
`nvim/.config/nvim/lua/config/lazy.lua`.

## Compiling and viewing

`maplocalleader` is `\`, so every vimtex command starts with `\l`:

| Command | Does |
|---|---|
| `\ll` | Compile the document (runs latexmk in the background, auto-recompiles on save) |
| `\lv` | Open/focus the PDF in zathura, jump to the current line (forward search) |
| `\lk` | Stop compilation |
| `\lK` | Stop all compilations (all open projects) |
| `\lc` | Clean aux files (`.aux`, `.log`, etc.) |
| `\lC` | Clean *all* generated files, including the PDF |
| `\le` | Show compile errors in the quickfix list |
| `\lq` | View the raw compile log |
| `\lo` | Show compiler output |
| `\lt` | Open the table of contents sidebar |
| `\lT` | Toggle the table of contents sidebar |
| `\lg` | Show compilation status for this document |
| `\lG` | Show status for all open projects |
| `\li` / `\lI` | Show vimtex info / full info (useful for debugging) |
| `\lx` / `\lX` | Reload vimtex / reload vimtex state |
| `\ls` | Toggle between main file and subfile |
| `\la` | Open vimtex's context menu |

In zathura: `Ctrl+click` on text in the PDF jumps back to that line in Neovim
(inverse search) — works out of the box, no extra setup needed.

Normal workflow: open a `.tex` file, `\ll` once (it stays running and
auto-recompiles on every save), `\lv` to open the PDF next to it. From then on
it's just: write → save → PDF updates itself.

## Navigation and text objects

vimtex adds LaTeX-aware text objects, usable with `d`, `c`, `y`, `v`, etc.:

| Object | Selects |
|---|---|
| `ic` / `ac` | A command (inner = arguments, around = whole `\command{...}`) |
| `ie` / `ae` | An environment (inner = body, around = including `\begin`/`\end`) |
| `id` / `ad` | Delimiters (`()`, `[]`, `{}`, ...) |
| `i$` / `a$` | A math environment |
| `iP` / `aP` | A section |
| `im` / `am` | An item (in a list) |

Example: cursor inside `\textbf{hello}`, `dic` deletes `hello`, `dac` deletes
the whole `\textbf{hello}`.

Motions:

| Mapping | Moves to |
|---|---|
| `]]` / `[[` | Next / previous section start |
| `][` / `[]` | Next / previous section end |
| `]m` / `[m` | Next / previous environment start |
| `]M` / `[M` | Next / previous environment end |
| `]n` / `[n` | Next / previous math environment |
| `]*` / `[*` | Next / previous comment |
| `%` | Jump between matching delimiters (also jumps `\begin` ↔ `\end`) |

## Snippets

Type the trigger, a popup appears (blink.cmp), press `Tab` to accept **and**
expand it in one keystroke. `Tab`/`Shift-Tab` then hop between the snippet's
placeholder fields (`$1`, `$2`, ...) until you land on `$0` (final cursor spot).

**Important caveat:** almost every snippet in this pack (`beg`, `-i`, `-e`,
`sec`, `mk`, `dm`, formatting commands, references, ...) has a `show_condition`
that checks vimtex's syntax state:

- Most require being **inside `\begin{document}...\end{document}`** — they
  won't show up while you're still in the preamble. That also means `beg`
  can't be used to create the `document` environment itself — write that by
  hand:
  ```tex
  \documentclass{article}
  \begin{document}

  \end{document}
  ```
- Math-entry snippets (`mk`, `dm`, `ali`, ...) additionally require being
  *outside* math mode (they're for entering math, not stacking inside it).

If a trigger you expect to work produces nothing, this condition is the first
thing to check — it's not a bug, it's the pack deciding it doesn't make sense
in the current context.

### Math — entering math mode

| Trigger | Expands to |
|---|---|
| `mk` | Inline math: `$|$` |
| `dm` | Display math: `\[ | \]` |
| `ali` | `align` / `align*` / `aligned` |
| `gat` | `gather` / `gather*` / `gathered` |
| `eqn` | `equation` / `equation*` |

### Matrices and cases

| Trigger | Expands to |
|---|---|
| `bmat`, `pmat`, `vmat`, `Vmat`, `Bmat` + `NxM` | A matrix of that dimension with the matching bracket style (`b`=`[]`, `p`=`()`, `v`=`\|\|`, `V`=`‖‖`, `B`=`{}`). E.g. `pmat2x3` |
| add `a` after the dimension | Augmented matrix, e.g. `bmat2x3a` |
| `cases`, `2cases`, `3cases`, ... | A `cases` array; plain `cases` defaults to 2 rows |

### Delimiters

| Trigger | Wraps the selection/cursor in |
|---|---|
| `lr(` | `\left( ... \right)` |
| `lrb` | `\left[ ... \right]` (bracket) |
| `lrc` | `\left\{ ... \right\}` (curly) |
| `lrp` | `\left\| ... \right\|` (pipe) |
| `lra` / `lrA` | `\left\langle ... \right\rangle` (angle brackets) |
| `lrm` | `\left. ... \right.` |

### Labels and references

| Trigger | Expands to |
|---|---|
| `alab` | `\label{type:name}` |
| `aref` | `\autoref{type:name}` |
| `cref` | `\cref{type:name}` (requires the `cleveref` package) |
| `Cref` | `\Cref{type:name}` (requires `cleveref`) |
| `eref` | `\eqref{type:name}` |
| `rref` | `\ref{type:name}` (plain ref) |

These are pattern-triggers: type the literal `aref`/`cref`/`Cref`/`eref`/`rref`
and it expands based on the matched letter.

### Sections and text formatting

| Trigger | Expands to |
|---|---|
| `sec` / `sec*` | `\section{title}`, with an optional `\label{sec:...}` field |
| `ssec` / `ssec*` | `\subsection{...}`, same label behaviour |
| `sssec` / `sssec*` | `\subsubsection{...}`, same label behaviour |
| `bf` | `\textbf{...}` |
| `it` | `\textit{...}` |
| `ttt` | `\texttt{...}` |
| `sc` | `\textsc{...}` (small caps) |
| `tu` | `\underline{...}` |
| `tov` | `\overline{...}` |
| `qq` | `\enquote{...}` (requires `csquotes`) |
| `sq` | `\enquote*{...}` (single quotes, requires `csquotes`) |

### Environments and lists

| Trigger | Expands to |
|---|---|
| `beg` | Generic `\begin{name}...\end{name}`, type the name first |
| `-i` | `itemize` with the first `\item` |
| `-e` | `enumerate` with the first `\item`, optional `[label=...]` |
| `--` | `\item` |
| `!-` | `\item[]` |

Full, always-up-to-date list of every trigger:
[snippets.md in the plugin repo](https://github.com/evesdropper/luasnip-latex-snippets.nvim/blob/main/snippets.md).

## Troubleshooting

- `\li` shows vimtex's status for the current document (compiler found,
  viewer configured, etc.) — the first stop for "why isn't compiling working."
- No PDF preview: check zathura is installed (`which zathura`) and that `\ll`
  actually finished without errors (`\le`).
- No completion popup at all in a `.tex` buffer: check `:checkhealth blink.cmp`
  for blink.cmp itself; check `:set filetype?` returns `tex`.
- Snippet doesn't expand even though the popup shows it and you pressed `Tab`:
  make sure nothing else is bound to `Tab` overriding blink.cmp — the config
  uses blink's `super-tab` keymap preset specifically so `Tab` both accepts
  and expands.
- Snippet trigger doesn't even appear in the popup: see the "Important
  caveat" above — check you're inside `\begin{document}` (and, for math
  triggers, outside math mode).
