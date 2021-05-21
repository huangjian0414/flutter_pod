#用于模拟器调试，合并一下debug模式的真机和模拟器库	
echo "\033[34m 开始合并debug库 \033[0m"

out='ios_frameworks'
rm -rf $out

build_file_name1='build/ios/Debug-iphoneos'
build_file_name2='build/ios/Debug-iphonesimulator'

#循环搜索并合并framework
readlipo_dir(){
    for file in `ls $1`
    do
        if [ -d $1"/"$file"/"$file".framework" ]  
        then
            #echo $1"/"$file"/"$file".framework/"$file
            lipo -create $1"/"$file"/"$file".framework/"$file $2"/"$file"/"$file".framework/"$file -output $out"/"$file".framework/"$file
        fi
    done
}


if [ -e $build_file_name1 ] && [ -e $build_file_name2 ]; then
    mkdir $out

    pathstr1="$build_file_name1"'/*/*.framework'
	pathstr2="$build_file_name2"'/*/*.framework'

    cp -r $pathstr1 $out
	cp -r $build_file_name1$'/App.framework' $out
	cp -r $build_file_name1$'/Flutter.framework' $out

    
	lipo -create $build_file_name1$'/App.framework/App' $build_file_name2$'/App.framework/App' -output $out$'/App.framework/App'
	lipo -create $build_file_name1$'/Flutter.framework/Flutter' $build_file_name2$'/Flutter.framework/Flutter' -output $out$'/Flutter.framework/Flutter'

	readlipo_dir $build_file_name1 $build_file_name2

	cp -r $out $'../'  #复制到外层的ios_framework
	rm -rf $out
	echo "\033[34m 合并完成 path：../ios_frameworks \033[0m"
else
	echo "\033[31m 合并失败，请先build debug真机模式和debug模拟器模式 \033[0m"
fi



