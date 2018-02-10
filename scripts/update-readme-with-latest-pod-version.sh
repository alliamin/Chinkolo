#!/bin/sh

git config credential.helper 'cache --timeout=300'
git config user.email "ali_amin@live.com"
git config user.name "cisclub"
git clone --depth 1 https://${GITHUB_PERSONAL_TOKEN}@github.com/cisclub/Chinkolo.git
git checkout origin master

# Get new version
version_line=$(ls -l | grep -i '^  s.version' Moya.podspec)
version=$(echo $version_line | cut -d \= -f 2)
version=$(echo $version | tr -d \" | tr -d ' ')

# Update Readme(s)
## Update pod 'Moya'
sed -i -e "s#pod 'Moya'.*#pod 'Moya' '~> ${version}'#" *.md
## Update pod 'Moya/RxSwift'
sed -i -e "s#pod 'Moya/RxSwift'.*#pod 'Moya/RxSwift' '~> ${version}'#" *.md
## Update pod 'Moya/ReactiveSwift'
sed -i -e "s#pod 'Moya/ReactiveSwift'.*#pod 'Moya/ReactiveSwift' '~> ${version}'#" *.md

cd Chinkolo/
echo "in Chinkolo"
git commit -m "Update 'Pod install' in Readme"
echo "commit done"
git push origin master
echo "pushing to master"
