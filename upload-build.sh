#!/usr/bin/env bash

# Generate build info
rel_date="$(date "+%Y%m%d")" # ISO 8601 format
rel_friendly_date="$(date "+%B %-d, %Y")" # "Month day, year" format
clang_version="$(install/bin/clang --version | head -n1 | cut -d' ' -f4)"

# Generate release info
builder_commit="$(git rev-parse HEAD)"
pushd llvm-project
llvm_commit="$(git rev-parse HEAD)"
short_llvm_commit="$(cut -c-8 <<< $llvm_commit)"
popd

llvm_commit_url="https://github.com/llvm/llvm-project/commit/$llvm_commit"
binutils_ver="$(ls | grep "^binutils-" | sed "s/binutils-//g")"

git config --global credential.helper store
# Update Git repository
echo "https://lateautumn:$GITHUB_PASSWORD@gitea.com" > $HOME/.git-credentials
git clone "https://gitea.com/lateautumn/LateAutumn-clang" rel_repo

pushd rel_repo
git config --global user.name "lateautumn233" && git config --global user.email 3487467850@qq.com
cp -r ../install/* .
git config --global http.version HTTP/1.1
# Keep files that aren't part of the toolchain itself
git lfs track "*.so"
git add .gitattributes
git checkout README.md LICENSE
git add .
git commit -am "Update to $rel_date build

LLVM commit: $llvm_commit_url
binutils version: $binutils_ver
Builder commit: https://github.com/$GH_BUILD_REPO/commit/$builder_commit"
git lfs push origin main
until git push ; do sleep 2 ; done ; echo succeed
popd
