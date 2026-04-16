
eval "$(/opt/homebrew/bin/brew shellenv)"

[[ -z "$BITBUCKET_HTTP_ACCESS_TOKEN" ]] && export BITBUCKET_HTTP_ACCESS_TOKEN=$(op read "op://Employee/Bitbucket Access Token/credential")

[[ -z "$JIRA_PERSONAL_ACCESS_TOKEN" ]] && export JIRA_PERSONAL_ACCESS_TOKEN=$(op read "op://Employee/Jira Access Token/credential")

[[ -z "$ANTHROPIC_API_KEY" ]] && export ANTHROPIC_API_KEY=$(op read "op://Employee/Anthropic API Key/credential")