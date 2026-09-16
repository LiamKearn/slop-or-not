#!/usr/bin/env bash
set -eux

# This script generates a script which uses the Github CLI to block the list of agent users.

USER_LIST="github-users-list"
OUTPUT_FILE_NAME="gh-cli-block-user.bash"

{
    cat <<'BASH'
#!/usr/bin/env bash
set -ux # Intentionally leave failures, sometimes the user may already have one of these blocked.

# This script blocks known agent users using the GH CLI

GH_CLI="gh"

if ! hash "$GH_CLI"
then
    printf "%s is not installed\n" "$GH_CLI"
    exit 1
fi

if ! "$GH_CLI" auth status --json hosts --jq '.hosts["github.com"][].scopes' | grep -qE "^user,| user"
then
    printf "You must have access to the user scope with your github CLI.\n"
    printf "Try running '%s auth refresh -h github.com -s user'\n" "$GH_CLI"
    exit 1
fi

# BEGIN GENERATED
BASH
    while read -r LINE; do
        [[ "$LINE" = "#"* ]] && continue
        printf "GH_PAGER=\"\" gh api --method PUT /user/blocks/%s\n" "$LINE"
    done < "$USER_LIST"
    printf "# END GENERATED\n"
} > "$OUTPUT_FILE_NAME"

