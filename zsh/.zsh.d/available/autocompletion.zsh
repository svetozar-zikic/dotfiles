zinit light "zsh-users/zsh-completions"
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zstyle ":completion:*" rehash true
zstyle ":completion:*" completer _complete _correct _ignored _approximate
zstyle ":completion:::*:default" menu no select
zstyle ":completion:*" use-cache on
zstyle ":completion:*" cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}"
zstyle ":completion:*:warnings" format "%BSorry, no matches for: %d%b"
zstyle ":completion:*:commands" rehash 1
