#!/bin/sh

SWIFT_VERSION=4.2 carthage bootstrap $CARTHAGE_VERBOSE --platform ios --color auto --cache-builds --no-use-binaries
cd SnowplowSwiftDemo
SWIFT_VERSION=4.2 carthage bootstrap $CARTHAGE_VERBOSE --platform ios --color auto --cache-builds --no-use-binaries
cd ..
