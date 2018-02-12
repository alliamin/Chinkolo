#!/bin/sh


#Update and Push changes if last commit is not "Update Readme"
last_sha=$(git rev-parse HEAD)
commit_message=$(git log -1 --pretty=%B $last_sha)
echo "cm -> ${commit_message}"

if [ commit_message = "Update Readme" ]; then
	echo "last commit is \"Update Readme\", continue ..."
else
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

	echo "Pushing chnages to Readme(s)."
	git config credential.helper 'cache --timeout=300'
	git config user.email "ali_amin@live.com"
	git config user.name "cisclub"
	git add *.md
	git commit -m "Update Readme"
	echo "commit done"
	 git push https://${GITHUB_PERSONAL_TOKEN}@github.com/cisclub/Chinkolo.git master
	echo "pushing to master"
fi