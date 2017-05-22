#!/bin/sh

#  lint.sh
#

if [ -z "$CARTHAGE" ]; then
	if which swiftlint >/dev/null; then
		swiftlint
	else
		echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
	fi
fi
