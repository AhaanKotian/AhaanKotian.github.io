#!/usr/bin/env bash
#
# Build the Hugo site and publish it into the ROOT of this repo.
#
# This repo holds BOTH the Hugo source and the generated site:
#   * source  -> config/ content/ assets/ layouts/ static/ themes/ resources/
#   * output  -> index.html css/ js/ dist/ media/ project/ publication/ tags/ ...
#
# GitHub Pages serves a <user>.github.io repo from the branch root, so the
# generated files have to sit at the top level next to the source folders.
#
# To stay safe, this script builds into a scratch directory first and then
# mirrors that directory onto the repo root, deleting stale output files but
# never touching the source folders listed in KEEP below.
#
# Usage:
#   ./build.sh            # build for production (https://AhaanKotian.github.io/)
#   ./build.sh --dry-run  # show what would change, write nothing

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_URL="https://AhaanKotian.github.io/"
STAGING="$(mktemp -d "${TMPDIR:-/tmp}/hugo_build.XXXXXX")"
trap 'rm -rf "$STAGING"' EXIT

# Everything the build must NOT delete from the repo root. Add new source
# files/folders here if you ever create them.
KEEP=(
  .git
  .gitignore
  .hugo_build.lock
  .DS_Store
  CONTENT_GUIDE.md
  build.sh
  R
  assets
  config
  content
  hugo_stats.json
  index.Rmd
  layouts
  netlify.toml
  personal_website.Rproj
  resources
  static
  themes
)

RSYNC_FLAGS=(-a --delete)
for path in "${KEEP[@]}"; do
  RSYNC_FLAGS+=(--exclude "/$path")
done

if [[ "${1:-}" == "--dry-run" ]]; then
  RSYNC_FLAGS+=(--dry-run --itemize-changes)
  echo "==> DRY RUN: nothing will be written to the repo root"
fi

if ! command -v hugo >/dev/null 2>&1; then
  echo "ERROR: 'hugo' is not on your PATH." >&2
  echo "Install Hugo Extended v0.131.0 - see CONTENT_GUIDE.md for instructions." >&2
  exit 1
fi

echo "==> Building site with $(hugo version)"
hugo --source "$REPO_DIR" --destination "$STAGING" --baseURL "$BASE_URL" --cleanDestinationDir

echo "==> Publishing build output to repo root: $REPO_DIR"
rsync "${RSYNC_FLAGS[@]}" "$STAGING"/ "$REPO_DIR"/

echo
echo "==> Done. Review the changes, then commit and push:"
echo "      git -C \"$REPO_DIR\" status"
echo "      git -C \"$REPO_DIR\" add -A"
echo "      git -C \"$REPO_DIR\" commit -m 'Update site'"
echo "      git -C \"$REPO_DIR\" push"
