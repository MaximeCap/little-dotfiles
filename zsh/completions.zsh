# Shell completions
#
# Completions are cached in $XDG_DATA_HOME/zsh/completions as _<tool> files.
# A file is (re)generated when the tool binary is newer than the cached file,
# so upgrades are picked up automatically.

_COMP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/completions"
[[ -d $_COMP_DIR ]] || mkdir -p "$_COMP_DIR"

_cache_completion() {
  local tool=$1; shift
  local file="$_COMP_DIR/_$tool"
  local bin
  bin=$(command -v "$tool" 2>/dev/null) || return
  if [[ ! -f $file || $bin -nt $file ]]; then
    "$@" >"$file" 2>/dev/null || rm -f "$file"
  fi
}

_cache_completion kubectl  kubectl completion zsh
_cache_completion helm     helm completion zsh
_cache_completion gh       gh completion -s zsh
_cache_completion docker   docker completion zsh
_cache_completion flux flux completion zsh

unset _COMP_DIR
unfunction _cache_completion
