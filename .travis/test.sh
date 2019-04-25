#!/bin/sh

set -o pipefail

xcodebuild -sdk iphonesimulator \
	-destination "${TEST_PLATFORM}" \
	-project Snowplow.xcodeproj \
	-scheme Snowplow-iOS \
	clean test \
	| xcpretty

xcodebuild archive -project ./SnowplowSwiftDemo/SnowplowSwiftDemo.xcodeproj \
	-scheme SnowplowSwiftDemo \
	-archivePath ./build/ \
	-allowProvisioningUpdates \
	| xcpretty
