export PROJECT_ROOT="$PROJECT_DIR"/..
  
    if [ "${CONFIGURATION}" = "Release" ]; then
        $PROJECT_ROOT/node_modules/react-native-salesforce-chat-sdk/ios-frameworks/ServiceCore.xcframework/ios-arm64/ServiceCore.framework/prepare-framework
    else
        $PROJECT_ROOT/node_modules/react-native-salesforce-chat-sdk/ios-frameworks/ServiceCore.xcframework/ios-arm64_x86_64-simulator/ServiceCore.framework/prepare-framework
    fi;