#!/bin/sh

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

# Push changes
git config credential.helper 'cache --timeout=300'
git config user.email "aamin@instabug.com"
git config user.name "CircleCI"
git clone --depth 1 https://2897f7b075bb7b899893356f63c7567625e16fd1@github.com/cisclub/Chinkolo.git
cd Chinkolo/
git commit --allow-empty -m "Update 'Pod install' in Readme"
git push -u origin master
