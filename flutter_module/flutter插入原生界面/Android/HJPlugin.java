package com.example.flutter_module.host;
import org.jetbrains.annotations.NotNull;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.StandardMessageCodec;

public class HJPlugin implements FlutterPlugin {


    @Override
    public void onAttachedToEngine(@NonNull @NotNull FlutterPlugin.FlutterPluginBinding binding) {

        binding.getPlatformViewRegistry().registerViewFactory("plugins.hj/hjView", new HJPlatformFactory(StandardMessageCodec.INSTANCE));
    }

    @Override
    public void onDetachedFromEngine(@NonNull @NotNull FlutterPlugin.FlutterPluginBinding binding) {

    }

}
