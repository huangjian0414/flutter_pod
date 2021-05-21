if [ -z $out ]; then
    out='ios_frameworks'
fi

flutter_build_func='' #build方式
build_file_name='' #build文件夹名称

if [[ $1 == 'release' ]]; then #relase模式 只能真机
        if [[ $2 == 'sim' ]]; then
            echo "\033[31m relase模式 只能真机，编译真机ing \033[0m"
        fi
        flutter_build_func='flutter_build_release_device'
        build_file_name='Release-iphoneos'

elif [[ $1 == 'debug' ]]; then #debug  分模拟器和真机
    if [[ $2 == 'sim' ]]; then 
        flutter_build_func='flutter_build_debug_simulator'
        build_file_name='Debug-iphonesimulator'
    else
        flutter_build_func='flutter_build_debug_device'
        build_file_name='Debug-iphoneos'
    fi
elif [[ $1 == 'sim' ]]; then #模拟器 只能debug
        flutter_build_func='flutter_build_debug_simulator'
        build_file_name='Debug-iphonesimulator'
else
    flutter_build_func='flutter_build_debug_device'  #默认debug 真机
    build_file_name='Debug-iphoneos'
fi

echo "\033[34m 准备输出所有文件到目录: $out \033[0m"

echo "\033[34m 清除 $build_file_name 编译文件 \033[0m"
#find . -d -name build | xargs rm -rf
#flutter clean
rm -rf $'build/ios/'$build_file_name

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
### build方法
flutter_build_debug_simulator(){
    flutter build ios --debug --simulator
}
flutter_build_debug_device(){
    flutter build ios --debug
}
flutter_build_release_device(){
    flutter build ios --release --no-codesign
}

echo "\033[34m 编译 $build_file_name \033[0m"

$flutter_build_func

#framework复制方法
copy_framework(){
    xcrun bitcode_strip $'build/ios/'$build_file_name$'/Flutter.framework/Flutter' -r -o $'build/ios/'$build_file_name$'/Flutter.framework/Flutter'
    pathstr='build/ios/'"$build_file_name"'/*/*.framework'
    
    cp -r $pathstr $out
    cp -r $'build/ios/'$build_file_name$'/App.framework' $out
    cp -r $'build/ios/'$build_file_name$'/Flutter.framework' $out
}

echo "\033[34m 编译flutter完成 \033[0m"
mkdir $out

copy_framework

echo "\033[34m 复制framework库到临时文件夹: $out 完成 \033[0m"

libpath='../'

rm -rf "$libpath/ios_frameworks"
mkdir $libpath
cp -r $out $libpath

echo "\033[34m 复制库文件 $out 到: $libpath 完成 \033[0m"
rm -rf $out
