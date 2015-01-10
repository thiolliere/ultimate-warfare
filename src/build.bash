#!/bin/bash

cd "$(dirname $0)"
cd ..
dir="$(pwd)"
name="$(cd ../ | basename $dir)"

#linux
zip -9 -q -r "$name".love src

#windows donwload love-0.9-win32 and love-0.9-win64
# and create the dir windows and in win32 and win64
cd "$dir"/windows/win32
cat love.exe ../../"$name".love > "$name".exe
cd "$dir"/windows/win64
cat love.exe ../../"$name".love > "$name".exe

#Mac OS X need previous action like download and modifaction of info.plist..
cd "$dir"
unzip -q "$name"_osx.zip
cp "$name".love "$name".app/Contents/Resources/
zip -9qr "$name"_osx.zip "$name".app
rm -r "$name".app
