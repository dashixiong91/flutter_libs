package com.xin1t.app_ffi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * AppFfiPlugin
 * 考虑到此插件仅仅支持作为ffi的模板项目，并不实际需要插件的能力，所以删除了默认的代码
 */
public class AppFfiPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    
  }
}
