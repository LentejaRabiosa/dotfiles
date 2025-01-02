if status is-interactive
    # Commands to run in interactive sessions can go here

	# Check if running in a TTY (non-graphical session)
	if test -z "$DISPLAY"
		exec bash --login
	end

    alias ls="eza"
    alias l="eza -la"
    alias t="eza -T"
    alias hx="helix"
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

    fish_vi_key_bindings

	if not set -q TMUX
        tmux new-session
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

