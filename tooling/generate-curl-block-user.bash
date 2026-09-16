#!/usr/bin/env bash
set -eux

# This script generates a script which uses CURL and the Github API to block the list of agent users.

USER_LIST="github-users-list"
OUTPUT_FILE_NAME="curl-block-user.bash"


{
    cat <<'BASH'
#!/usr/bin/env bash
set -eux

# This script blocks known agent users using CURL

eof_safe_read() {
    if ! read -rp "$1" "$2"; then
        exit 1
    fi
}

if ! hash curl
then
    printf "Curl is not installed\n"
    exit 1
fi

if [[ ! -v AUTH_TOKEN ]] || [[ -z "${AUTH_TOKEN}" ]];
then
    printf "To authorize your account you will an access token with the user scope\n"
    printf "You can generate one here: https://github.com/settings/personal-access-tokens/new\n"
    printf "Grant it the 'Block another user' permission *ensuring* to select read *and* write\n"
    eof_safe_read "Enter your Authorization Token: " AUTH_TOKEN
    [[ -z "${AUTH_TOKEN}" ]] && printf "A AUTH_TOKEN must be supplied\n" && exit 1
fi

set +e # Intentionally leave failures, sometimes the user may already have one of these blocked.
# BEGIN GENERATED
BASH
    while read -r LINE; do
        [[ "${LINE}" = "#"* ]] && continue
        cat <<BASH
curl -X PUT https://api.github.com/user/blocks/${LINE} \\
  -H "Accept: application/vnd.github+json" \\
  -H "Authorization: Bearer \${AUTH_TOKEN}" \\
  -H "X-GitHub-Api-Version: 2026-03-10" \\
  -L
BASH
    done < "${USER_LIST}"
    printf "# END GENERATED\n"
} > "${OUTPUT_FILE_NAME}"

