## Rust
#

## Rust evironment and toolchain management with rustup
#
# See: https://rustup.rs/
#
# Install: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# NOTE: Install script adds sourcing of ~/.cargo/env in many places
#       But it seems sufficient to put it here
#

if [ -f  "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

