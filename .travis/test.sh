#!/bin/sh

set -o pipefail

xcodebuild build -project ./SnowplowSwiftDemo/SnowplowSwiftDemo.xcodeproj \
	-scheme SnowplowSwiftDemo \
	-archivePath ./build/ \
	-configuration Debug \
	-destination "platform=iOS Simulator,OS=12.2,name=iPhone Xʀ" \
	CODE_SIGN_IDENTITY="" \
	CODE_SIGNING_REQUIRED="NO" \
	CODE_SIGN_ENTITLEMENTS="" \
	CODE_SIGNING_ALLOWED="NO" \
	| xcpretty
