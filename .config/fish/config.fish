if status is-interactive
    # Commands to run in interactive sessions can go here

    alias ls="eza -l"
    alias l="eza -la"
    alias ll="l -s type"
    alias t="l -T"
    alias hx="helix"

    fish_vi_key_bindings
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set --export VCPKG_ROOT "$HOME/vcpkg"
