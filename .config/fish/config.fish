if status is-interactive
    # Commands to run in interactive sessions can go here

    alias ls="eza -1 -s type"
    alias l="eza -1 -a -s type"
    alias ll="eza -l -a -s type"
    alias t="l -T"
    alias hx="helix"

    fish_vi_key_bindings

    set fish_cursor_default     block      blink
    set fish_cursor_insert      block      blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual      block
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set --export VCPKG_ROOT "$HOME/vcpkg"
set --export EDITOR nvim
