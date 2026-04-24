# Refresh Artifactory credentials for both registries:
#   - default registry (npm)
#   - tlo-npm registry (@odyssey scoped packages)
# Syncs new tokens into 1Password and refreshes env var references.
npm-login() {
  local artifactory_domain="artifactory.internal.taillight.cloud"
  local npm_registry_key="${artifactory_domain}/artifactory/api/npm/npm/"
  local tlo_registry_key="${artifactory_domain}/artifactory/api/npm/tlo-npm/"

  local artifactory_url="https://${artifactory_domain}"
  local npm_registry_url="https://${npm_registry_key}"
  local tlo_registry_url="https://${tlo_registry_key}"

  echo ""
  echo "Before continuing, make sure you are already logged in to Artifactory"
  echo "via the web UI at: ${artifactory_url}"
  echo ""
  read -q "REPLY?Have you logged in via the web UI? (y/n) " || { echo ""; echo "Aborted."; return 1; }
  echo ""

  # Thought I could maybe auto-login but there is probably access token business going on that makes this not work
  # op run -- curl -H "Content-Type: application/json" -d '{"username":"op://Employee/Tail Light/username", "password":"op://Employee/Tail Light/password"}' https://${artifactory_domain}/ui/api/v1/access/auth/login

  echo "Logging in to npm registry (unscoped)..."
  npm login --registry="$npm_registry_url" || exit 1

  echo "Logging in to tlo-npm registry (@odyssey scope)..."
  npm login --registry="$tlo_registry_url" --scope=@odyssey || exit 1

  echo "Extracting new tokens to env vars..."
  export NPM_TOKEN=$(grep "${npm_registry_key}.*_authToken" ~/.npmrc | sed 's/.*_authToken=//')
  export TLO_NPM_TOKEN=$(grep "${tlo_registry_key}.*_authToken" ~/.npmrc | sed 's/.*_authToken=//')

  echo "Updating 1Password..."
  local item_name="JFrog Artifactory Tokens"
  local vault_name="Employee"
  local fields=(
    "url[url]=${artifactory_url}"
    "npm-token[concealed]=${NPM_TOKEN}"
    "tlo-npm-token[concealed]=${TLO_NPM_TOKEN}"
  )

  if op item get "$item_name" --vault "$vault_name" >/dev/null 2>&1; then
    op item edit "$item_name" --vault "$vault_name" "${fields[@]}"
  else
    op item create --vault "$vault_name" --category "Secure Note" --title "$item_name" "${fields[@]}"
  fi

  # TODO: this reset was breaking docker container usage of npm. Investigate setting/passing through env var for container
  #echo "Resetting npmrc env references..."
  #npm config set //${npm_registry_key}:_authToken=\$\{NPM_TOKEN\}
  #npm config set //${tlo_registry_key}:_authToken=\$\{TLO_NPM_TOKEN\}

  echo "Done."
}