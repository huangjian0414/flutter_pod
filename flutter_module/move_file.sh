if [ -z $out ]; then
    out='ios_frameworks'
fi

echo "\033[34m 准备输出所有文件到目录: $out \033[0m"

echo "\033[34m 清除所有已编译文件 \033[0m"
find . -d -name build | xargs rm -rf
flutter clean
rm -rf $out
rm -rf build

flutter packages get

addFlag(){
    cat .ios/Podfile > tmp1.txt
    echo "use_frameworks!" >> tmp2.txt
    cat tmp1.txt >> tmp2.txt
    cat tmp2.txt > .ios/Podfile
    rm tmp1.txt tmp2.txt
}

echo "\033[34m 检查 .ios/Podfile文件状态 \033[0m"
a=$(cat .ios/Podfile)
if [[ $a == use* ]]; then
    echo "\033[34m 已经添加use_frameworks, 不再添加 \033[0m"
else
    echo "\033[34m 未添加use_frameworks,准备添加 \033[0m"
    addFlag
    echo "\033[34m 添加use_frameworks 完成 \033[0m"
fi

flutter_build_debug_simulator(){
    flutter build ios --debug --simulator
}
flutter_build_debug_device(){
    flutter build ios --debug
}
flutter_build_release_device(){
    flutter build ios --release --no-codesign
}

echo "\033[34m 编译flutter \033[0m"
if [[ $1 == 'release' ]]; then #relase模式 只能真机
        if [[ $2 == 'sim' ]]; then
            echo "\033[31m relase模式 只能真机，编译真机ing \033[0m"
        fi
        flutter_build_release_device
elif [[ $1 == 'debug' ]]; then
    if [[ $2 == 'sim' ]]; then
        flutter_build_debug_simulator
    else
        flutter_build_debug_device
    fi
elif [[ $1 == 'sim' ]]; then #模拟器 只能debug
        flutter_build_debug_simulator
else
    flutter_build_debug_device  #默认debug 真机
fi

copy_release_iphone(){
    xcrun bitcode_strip build/ios/Release-iphoneos/Flutter.framework/Flutter -r -o build/ios/Release-iphoneos/Flutter.framework/Flutter
    cp -r build/ios/Release-iphoneos/*/*.framework $out
    cp -r build/ios/Release-iphoneos/App.framework $out
    cp -r build/ios/Release-iphoneos/Flutter.framework $out
}
copy_debug_iphone(){
    xcrun bitcode_strip build/ios/Debug-iphoneos/Flutter.framework/Flutter -r -o build/ios/Debug-iphoneos/Flutter.framework/Flutter
    cp -r build/ios/Debug-iphoneos/*/*.framework $out
    cp -r build/ios/Debug-iphoneos/App.framework $out
    cp -r build/ios/Debug-iphoneos/Flutter.framework $out
}
copy_debug_simulator(){
    xcrun bitcode_strip build/ios/Debug-iphonesimulator/Flutter.framework/Flutter -r -o build/ios/Debug-iphonesimulator/Flutter.framework/Flutter
    cp -r build/ios/Debug-iphonesimulator/*/*.framework $out
    cp -r build/ios/Debug-iphonesimulator/App.framework $out
    cp -r build/ios/Debug-iphonesimulator/Flutter.framework $out
}

echo "\033[34m 编译flutter完成 \033[0m"
mkdir $out
if [[ $1 == 'release' ]]; then #relase模式 只能真机
        copy_release_iphone
elif [[ $1 == 'debug' ]]; then
    if [[ $2 == 'sim' ]]; then
        copy_debug_simulator
    else
        copy_debug_iphone
    fi
elif [[ $1 == 'sim' ]]; then #模拟器 只能debug
    copy_debug_simulator
else
    copy_debug_iphone  #默认debug 真机
fi

echo "\033[34m 复制framework库到临时文件夹: $out \033[0m"

libpath='../'

rm -rf "$libpath/ios_frameworks"
mkdir $libpath
cp -r $out $libpath

echo "\033[34m 复制库文件到: $libpath \033[0m"
rm -rf $out
