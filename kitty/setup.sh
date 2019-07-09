#!/usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/kitty)"

info "Setting up kitty..."

substep_info "Creating kitty folder..."
mkdir -p $DESTINATION

find * -maxdepth 0 -name "*.conf" -o -type d | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Finished setting up kitty."
