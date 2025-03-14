#!/usr/bin/env bash

set -u  # Treat unset variables as an errors

#################################
# 1) Identify the Desktop folder
#################################
DESKTOP_PATH="${HOME}/Desktop"

if [ ! -d "${DESKTOP_PATH}" ]; then
  echo "Error: No Desktop folder found at '${DESKTOP_PATH}'."
  echo "Please adjust the script if your Desktop path is different."
  exit 1
fi

echo "Searching for Git repositories under: ${DESKTOP_PATH}"
echo

##########################################
# 2) Find all .git folders on the Desktop
##########################################
# -type d       = find directories only
# -name ".git"  = name of the .git folder
# 2>/dev/null   = suppress "Permission denied" errors if any
gitdirs=$(find "${DESKTOP_PATH}" -type d -name ".git" 2>/dev/null)

# If none found, exit early
if [ -z "$gitdirs" ]; then
  echo "No Git repositories found on the Desktop."
  exit 0
fi

##########################################
# 3) Loop over each Git repo directory
##########################################
for gitdir in $gitdirs; do
  # The repository's root directory is the parent of the .git folder
  repo_dir="$(dirname "$gitdir")"

  echo "--------------------------------"
  echo "Processing repository in: $repo_dir"
  echo "--------------------------------"

  # Ensure it has a remote "origin" (otherwise skip)
  remote_url="$(git -C "$repo_dir" config --get remote.origin.url)"
  if [ -z "$remote_url" ]; then
    echo "No 'origin' remote found in $repo_dir. Skipping..."
    echo
    continue
  fi

  # Enter the repo
  pushd "$repo_dir" > /dev/null

  ################################
  # 3a) Pull latest from remote
  ################################
  echo "Pulling latest from $remote_url ..."
  if ! git pull; then
    echo "Pull failed (possibly a merge conflict). Skipping this repo..."
    popd > /dev/null
    echo
    continue
  fi

  ################################
  # 3b) Stage all changes
  ################################
  git add .

  ################################
  # 3c) Commit if there are changes
  ################################
  # We'll check if there's anything staged.
  if ! git diff --quiet --cached; then
    echo "Committing changes..."
    git commit -m "Automated commit"
  else
    echo "No changes to commit."
  fi

  ################################
  # 3d) Push to remote
  ################################
  echo "Pushing to $remote_url ..."
  git push

  # Return to previous directory
  popd > /dev/null
  echo
done

echo "Done processing all local Git repositories on the Desktop."
