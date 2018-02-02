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
## WIP
