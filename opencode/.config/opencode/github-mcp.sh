#!/bin/bash
# TODO: Remove this wrapper script once opencode supports env var substitution in command args.
# Currently, opencode's {env:VAR} substitution only works in the `environment` and `headers`
# blocks, not inside the `command` array. This script works around that by:
#   1. Sourcing ~/.zshenv to load GITHUB_MCP_PAT
#   2. Letting bash expand the variable before Docker runs
# See: https://github.com/anthropics/opencode/issues/XXX (if an issue gets filed)
source ~/.zshenv 2>/dev/null || true
exec docker run -i --rm \
  -e "GITHUB_PERSONAL_ACCESS_TOKEN=$GITHUB_MCP_PAT" \
  -e "GITHUB_TOOLSETS=all" \
  ghcr.io/github/github-mcp-server stdio
