# enable Ctrl + S for forward search (https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r)
stty -ixon
# allow automatic open auto-completion (https://stackoverflow.com/questions/66507024/how-to-enable-tab-completion-arrow-keys-selection-for-the-kill-command-in-zsh)
zstyle ':completion:*' menu select

scan_and_move_files() {
    mode="${1:-}"

    # ANSI colors for dry run
    YELLOW='\033[1;33m'
    GREEN='\033[1;32m'
    NC='\033[0m' # No Color

    if [ "$mode" != "--dry-run" ]; then
        printf "Move files matching *YYYYMMDD* into YYYY-MM-DD directories? [Y/yes to confirm]: "
        read answer
        # Lowercase the answer
        answer=$(printf "%s" "$answer" | tr '[:upper:]' '[:lower:]')

        if [ "$answer" != "y" ] && [ "$answer" != "yes" ]; then
            echo "Aborted by user."
            return 0
        fi
    fi

    for file in *; do
        [ -f "$file" ] || continue

        # Extract the first YYYYMMDD pattern from the filename
        datepart=$(printf "%s" "$file" | grep -oE '[0-9]{8}' | head -n 1 || true)

        if [ -n "$datepart" ]; then
            year=$(printf "%s" "$datepart" | cut -c1-4)
            month=$(printf "%s" "$datepart" | cut -c5-6)
            day=$(printf "%s" "$datepart" | cut -c7-8)
            target_dir="${year}-${month}-${day}"

            if [ "$mode" = "--dry-run" ]; then
                printf "%b%s%b -> %b%s/%s%b\n" "$YELLOW" "$file" "$NC" "$GREEN" "$target_dir" "$file" "$NC"
            else
                mkdir -p "$target_dir"
                mv -v "$file" "$target_dir/"
            fi
        fi
    done
    return 0
}

