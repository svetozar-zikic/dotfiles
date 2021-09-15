bindkey -v
bindkey "^A" beginning-of-line      # ctrl-a
bindkey "^E" end-of-line            # ctrl-e
bindkey "^F" forward-word           # ctrl-f
bindkey "^B" backward-word          # ctrl-b
bindkey "^K" vi-change-whole-line   # ctrl-k
bindkey "^[OF" end-of-line          # end key
bindkey "^[OH" beginning-of-line    # home key
bindkey "^[[2~" overwrite-mode      # insert key
bindkey "^[[3~" delete-char         # del key
bindkey "^[[1;5C" forward-word      # ctrl-rightarrow - move forward one word
bindkey "^[[1;5D" backward-word     # ctrl-leftarrow  - move backward one word
