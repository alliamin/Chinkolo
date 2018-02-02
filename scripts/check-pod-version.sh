#!/bin/sh


result=$(ls -l | grep -i '^  s.version' Moya.podspec)
echo ">>> $result"

version=$(echo $result | cut -d \= -f 2)
echo "Version is > $version"

version=$(echo $version | tr -d \" | tr -d ' ')
echo "Version is > $version"

# Update pod 'Moya'
sed -i -e "s#pod 'Moya'.*#pod 'Moya' '~> ${version}'#" *.md
# Update pod 'Moya/RxSwift'
sed -i -e "s#pod 'Moya/RxSwift'.*#pod 'Moya/RxSwift' '~> ${version}'#" *.md
# Update pod 'Moya/ReactiveSwift'
sed -i -e "s#pod 'Moya/ReactiveSwift'.*#pod 'Moya/ReactiveSwift' '~> ${version}'#" *.md

# Remove this
git diff
