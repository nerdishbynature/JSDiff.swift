SHA=$(shell git rev-parse HEAD)
BRANCH=$(shell git name-rev --name-only HEAD)

install:
	brew outdated || brew install node
	npm install -g browserify
	cd js && npm install
	gem install slather fastlane

test:
	fastlane code_coverage configuration:Debug --env default

post_coverage:
	slather coverage --input-format profdata -x --ignore "../**/*/Xcode*" --ignore "Carthage/**" --output-directory slather-report --scheme JSDiff JSDiff.xcodeproj
	curl -X POST -d @slather-report/cobertura.xml "https://codecov.io/upload/v2?token="$(CODECOV_TOKEN)"&commit="$(SHA)"&branch="$(BRANCH)"&job="$(TRAVIS_BUILD_NUMBER)

