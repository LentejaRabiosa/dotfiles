if status is-interactive
    # Commands to run in interactive sessions can go here

    alias ls="eza -l"
    alias l="eza -la"
    alias ll="l -s type"
    alias t="l -T"

    fish_vi_key_bindings

	if not set -q TMUX
        tmux new-session
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set --export VCPKG_ROOT "$HOME/vcpkg"

