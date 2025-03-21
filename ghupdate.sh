#!/usr/bin/env bash

set -u  # Treat unset variables as errors

#################################
# 1) Identify the Home directory
#################################
HOME_DIR="${HOME}"

if [ ! -d "${HOME_DIR}" ]; then
  echo "Error: The home directory '${HOME_DIR}' does not exist."
  exit 1
fi

echo "Searching for Git repositories under: ${HOME_DIR}"
echo

##########################################
# 2) Find all .git folders under HOME_DIR
##########################################
gitdirs=$(find "${HOME_DIR}" -type d -name ".git" 2>/dev/null)

# If none found, exit early
if [ -z "$gitdirs" ]; then
  echo "No Git repositories found under '${HOME_DIR}'."
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

  # Check if the remote URL refers to 'kiruko1025'
  if [[ "$remote_url" != *"kiruko1025"* ]]; then
    echo "Skipping repo: '$remote_url' does not appear to be for user 'kiruko1025'."
    echo
    continue
  fi

  echo "Remote '$remote_url' appears to be for user 'kiruko1025'. Proceeding..."

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

echo "Done processing all local Git repositories under ${HOME_DIR}."
