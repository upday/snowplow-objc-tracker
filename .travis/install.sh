#!/bin/sh

if [[ $PACKAGE_MANAGER == 'carthage' ]]; then
    carthage update --platform iOS
elif [[ $PACKAGE_MANAGER == 'cocoapods' ]]; then
    pod repo update
    pod install
    pod update
fi
