#!/usr/bin/env bash
set -ux # Intentionally leave failures, sometimes the user may already have one of these blocked.

# This script blocks known agent users using the GH CLI

GH_CLI="gh"

if ! hash "${GH_CLI}"
then
    printf "%s is not installed\n" "${GH_CLI}"
    exit 1
fi

coproc AUTH_STATUS_PROC { "${GH_CLI}" auth status --json hosts --jq '.hosts["github.com"][].scopes'; }
AUTH_PID="${AUTH_STATUS_PROC_PID:?}"

grep -qE "^user,| user" <&"${AUTH_STATUS_PROC[0]}"
FOUND_SCOPE=$?

if ! wait "${AUTH_PID}";
then
    printf "Could not obtain GH_CLI auth status\n"
    exit 1
fi

if [[ "${FOUND_SCOPE}" -ne 0 ]];
then
    printf "You must have access to the user scope with your github CLI.\n"
    printf "Try running '%s auth refresh -h github.com -s user'\n" "${GH_CLI}"
    exit 1
fi

# BEGIN GENERATED
GH_PAGER="" gh api --method PUT /user/blocks/claude
GH_PAGER="" gh api --method PUT /user/blocks/cursoragent
GH_PAGER="" gh api --method PUT /user/blocks/codex
GH_PAGER="" gh api --method PUT /user/blocks/ampagent
GH_PAGER="" gh api --method PUT /user/blocks/blackboxaicode
GH_PAGER="" gh api --method PUT /user/blocks/ellipsis-agent
GH_PAGER="" gh api --method PUT /user/blocks/Auto-GPT-Bot
GH_PAGER="" gh api --method PUT /user/blocks/openhands-agent
GH_PAGER="" gh api --method PUT /user/blocks/careerops-ledger
GH_PAGER="" gh api --method PUT /user/blocks/compozybot
GH_PAGER="" gh api --method PUT /user/blocks/ouroboros-agent
GH_PAGER="" gh api --method PUT /user/blocks/leeroo-coder
GH_PAGER="" gh api --method PUT /user/blocks/InsightFactoryAPP
GH_PAGER="" gh api --method PUT /user/blocks/Orkas-AI
# END GENERATED
