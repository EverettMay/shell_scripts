#!/usr/bin/env bash


gitdirs=$(find . -type d -name ".git")

for gitdir in $gitdirs; do
  # The repository directory is the parent of the .git folder
  repo_dir="$(dirname "$gitdir")"

  echo "----------"
  echo "Processing repository in: $repo_dir"
  echo "----------"

  # Ensure it's a valid Git repository by checking for remote
  remote_url="$(git -C "$repo_dir" config --get remote.origin.url)"
  if [ -z "$remote_url" ]; then
    echo "No remote 'origin' found in $repo_dir. Skipping..."
    continue
  fi

  # Change into the repo directory
  pushd "$repo_dir" > /dev/null

  # 1) Pull latest changes
  echo "Pulling latest changes from $remote_url ..."
  git pull
  # If git pull failed (non-zero exit code => conflict or other error), skip
  if [ $? -ne 0 ]; then
    echo "Pull failed (possibly a merge conflict). Skipping this repo..."
    popd > /dev/null
    continue
  fi

  # 2) Add all changes
  git add .

  # 3) Commit if there are changes to commit
  #    If there are no staged changes, 'git commit' exits with status 1, but that's not an error we care about.
  if ! git diff --quiet --cached; then
    echo "Committing changes..."
    git commit -m "Automated commit"
  else
    echo "No changes to commit."
  fi

  # 4) Push
  echo "Pushing to $remote_url ..."
  git push

  popd > /dev/null
  echo
done

echo "Done processing all local Git repositories."
