#!/bin/sh

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old site"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Copying site"
cp -r src/* public

echo "Updating gh-pages branch"
cp ./CNAME public 
cd public && git add --all && git commit -m ":rocket: Publicando sitio en gh-pages (publish.sh)"

git push origin gh-pages