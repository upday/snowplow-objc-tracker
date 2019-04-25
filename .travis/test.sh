#!/bin/sh

set -o pipefail

xcodebuild archive -project ./SnowplowSwiftDemo/SnowplowSwiftDemo.xcodeproj \
	-scheme SnowplowSwiftDemo \
	-archivePath ./build/ \
	-allowProvisioningUpdates \
	| xcpretty
