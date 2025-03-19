#!/usr/bin/env bash

# GitHub username
USERNAME="kiruko1025"

# Fetch SSH clone URLs for all public repositories via the GitHub API
REPOS=$(curl -s "https://api.github.com/users/${USERNAME}/repos?per_page=200" | grep ssh_url | cut -d '"' -f 4)

# Clone each repository
for REPO in $REPOS; do
    echo "Cloning $REPO..."
    git clone "$REPO"
done
