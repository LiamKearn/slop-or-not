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
curl -X PUT https://api.github.com/user/blocks/claude \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/cursoragent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/codex \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/ampagent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/blackboxaicode \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/ellipsis-agent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/Auto-GPT-Bot \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/openhands-agent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/careerops-ledger \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/compozybot \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/ouroboros-agent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/leeroo-coder \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/InsightFactoryAPP \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
curl -X PUT https://api.github.com/user/blocks/Orkas-AI \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${AUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -L
# END GENERATED
