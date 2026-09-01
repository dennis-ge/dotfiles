# Path to user specific configuration files
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# zinit (plugin manager)
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[[ -f $ZINIT_HOME/zinit.zsh ]] || { mkdir -p ${ZINIT_HOME:h}; git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME }
source $ZINIT_HOME/zinit.zsh

# Load OMZ libs we need (not the whole thing)
zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh   # emacs keys + ↑/↓ prefix history search
zinit snippet OMZP::git            # gst, ga, gc, gd, gcb, g, …
zinit snippet OMZP::kubectl        # k=kubectl + completion

# --- completions: cache slow ones, then fast -C (full rebuild only when a non-zinit dir changed) ---
_comp_cache_dir=~/.zsh/completions
mkdir -p "$_comp_cache_dir"
fpath=("$_comp_cache_dir" $fpath)

_cache_completion() {
  local cmd=$1 cache=$2 gen_cmd=$3
  local bin_path="$(command -v "$cmd" 2>/dev/null)"
  if [[ -n "$bin_path" && ( ! -f "$cache" || "$bin_path" -nt "$cache" ) ]]; then
    eval "$gen_cmd" > "$cache" 2>/dev/null
  fi
}
_cache_completion helm "$_comp_cache_dir/_helm" "helm completion zsh"
_cache_completion podman "$_comp_cache_dir/_podman" "podman completion zsh"
unfunction _cache_completion

autoload -Uz compinit
_zdump="$XDG_CACHE_HOME/zcompdump"; _stale=0
for d in $fpath; do
  [[ $d == *zinit* ]] && continue          # zinit manages its own completions dir
  [[ $d -nt $_zdump ]] && { _stale=1; break }
done
if [[ ! -s $_zdump || $_stale == 1 ]]; then compinit -d $_zdump; else compinit -C -d $_zdump; fi
unset _stale d _comp_cache_dir
zinit cdreplay -q                  # replay compdefs queued by the snippets

for file in ~/.{zshrc.local,aliases,exports};
do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Initialize tools
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi
eval "$(zoxide init zsh)"

# plugins that wrap ZLE widgets must load after local key bindings
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
