#!/bin/bash

# ==============================================================================
# Git Version & Changelog Manager (Conventional Commits + Gitmoji)
# Cross-Platform Compatibility: Linux Native & Windows Git Bash
# ==============================================================================

VERSION_FILE="version.json"
CHANGELOG_FILE="CHANGELOG.md"

# Ensure version.json exists with initial valid structure if missing
if [ ! -f "$VERSION_FILE" ]; then
	echo '{"major": 0, "minor": 1, "patch": 0, "build": 0, "string": "0.1.0.0"}' > "$VERSION_FILE"
fi

# Ensure CHANGELOG.md exists
if [ ! -f "$CHANGELOG_FILE" ]; then
	echo -e "# Changelog\n\nAll notable changes to this project will be documented in this file.\n" > "$CHANGELOG_FILE"
fi

# Fetch the latest commit hash, subject line, and full body message
COMMIT_HASH=$(git log -1 --format="%h" 2>/dev/null || echo "0000000")
COMMIT_MSG=$(git log -1 --format="%s" 2>/dev/null || echo "chore: initial commit")
COMMIT_BODY=$(git log -1 --format="%b" 2>/dev/null || echo "")

if [ -z "$COMMIT_HASH" ] || [ "$COMMIT_HASH" = "0000000" ]; then
	echo "⚠️ No active git commits found in this directory."
	exit 0
fi

# ------------------------------------------------------------------------------
# 1. Parse Current Version Values (Cross-platform stream editing parsing)
# ------------------------------------------------------------------------------
MAJOR=$(grep '"major":' "$VERSION_FILE" | sed -E 's/.*"major":[[:space:]]*([0-9]+).*/\1/')
MINOR=$(grep '"minor":' "$VERSION_FILE" | sed -E 's/.*"minor":[[:space:]]*([0-9]+).*/\1/')
PATCH=$(grep '"patch":' "$VERSION_FILE" | sed -E 's/.*"patch":[[:space:]]*([0-9]+).*/\1/')
BUILD=$(grep '"build":' "$VERSION_FILE" | sed -E 's/.*"build":[[:space:]]*([0-9]+).*/\1/')

# Fallback checking for empty evaluations
MAJOR=${MAJOR:-0}
MINOR=${MINOR:-0}
PATCH=${PATCH:-1}
BUILD=${BUILD:-0}

# ------------------------------------------------------------------------------
# 2. Determine Scope of Version Change (Conventional Commits + Gitmoji flags)
# ------------------------------------------------------------------------------
BUMP_TYPE="build" # Default increment level

# Check for Breaking Changes (Major Scale)
if echo "$COMMIT_MSG" | grep -qE "(^[a-zA-Z0-9_-]+\!:|BREAKING CHANGE:)" || echo "$COMMIT_BODY" | grep -q "BREAKING CHANGE:" || echo "$COMMIT_MSG" | grep -q "💥"; then
	BUMP_TYPE="major"
# Check for New Features (Minor Scale)
elif echo "$COMMIT_MSG" | grep -qE "^feat(\([a-zA-Z0-9_-]+\))?:" || echo "$COMMIT_MSG" | grep -qE "(✨|🚀|🎉)"; then
	BUMP_TYPE="minor"
# Check for Fixes, Refactors, or Optimization Tweaks (Patch Scale)
elif echo "$COMMIT_MSG" | grep -qE "^(fix|refactor|perf|chore|docs|style|test)(\([a-zA-Z0-9_-]+\))?:" || echo "$COMMIT_MSG" | grep -qE "(🐛|🚑|🔒|♻️|⚡|📝|🔧|🎨|✅)"; then
	BUMP_TYPE="patch"
fi

# Execute state calculations
case "$BUMP_TYPE" in
	"major")
		MAJOR=$((MAJOR + 1))
		MINOR=0
		PATCH=0
		BUILD=0
		CHANGELOG_CATEGORY="### 💥 Breaking Changes"
		;;
	"minor")
		MINOR=$((MINOR + 1))
		PATCH=0
		BUILD=0
		CHANGELOG_CATEGORY="### ✨ Features"
		;;
	"patch")
		PATCH=$((PATCH + 1))
		BUILD=0
		CHANGELOG_CATEGORY="### 🐛 Bug Fixes & Refactors"
		;;
	*)
		BUILD=$((BUILD + 1))
		CHANGELOG_CATEGORY="### 🔧 Maintenance & Builds"
		;;
esac

NEW_VERSION_STR="$MAJOR.$MINOR.$PATCH.$BUILD"

# Write out the structural state JSON file safely
cat <<EOF > "$VERSION_FILE"
{
  "major": $MAJOR,
  "minor": $MINOR,
  "patch": $PATCH,
  "build": $BUILD,
  "string": "$NEW_VERSION_STR"
}
EOF

# ------------------------------------------------------------------------------
# 3. Dynamic Changelog Construction
# ------------------------------------------------------------------------------
CURRENT_DATE=$(date +"%Y-%m-%d")
CLEAN_MESSAGE=$(echo "$COMMIT_MSG" | sed -E 's/^(feat|fix|refactor|perf|chore|docs|style|test)(\([a-zA-Z0-9_-]+\))?\!?:[[:space:]]*//')

# Build the temporary update snippet
TEMP_CHANGELOG=$(mktemp)
echo -e "## [$NEW_VERSION_STR] - $CURRENT_DATE\n" > "$TEMP_CHANGELOG"
echo -e "$CHANGELOG_CATEGORY\n" >> "$TEMP_CHANGELOG"
echo -e "- $CLEAN_MESSAGE ([$COMMIT_HASH](https://github.com/placeholder/repo/commit/$COMMIT_HASH))\n" >> "$TEMP_CHANGELOG"

# Append all previous changelog items cleanly below the new entry
tail -n +3 "$CHANGELOG_FILE" >> "$TEMP_CHANGELOG"
mv "$TEMP_CHANGELOG" "$CHANGELOG_FILE"

# ------------------------------------------------------------------------------
# 4. Repository Optimization Sync (Amends current workspace seamlessly)
# ------------------------------------------------------------------------------
git add "$VERSION_FILE" "$CHANGELOG_FILE"
git commit --amend --no-verify -C HEAD >/dev/null 2>&1

echo "📦 [Version Manager] Successfully updated tracking workspace to v$NEW_VERSION_STR"
