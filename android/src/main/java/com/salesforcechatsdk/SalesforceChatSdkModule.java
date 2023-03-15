package com.salesforcechatsdk;

import android.app.Activity;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.graphics.Color;

import androidx.annotation.NonNull;
import androidx.appcompat.widget.Toolbar;
import androidx.collection.LongSparseArray;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.salesforce.android.chat.core.ChatConfiguration;
import com.salesforce.android.chat.core.SessionInfoListener;
import com.salesforce.android.chat.core.SessionStateListener;
import com.salesforce.android.chat.core.model.ChatEndReason;
import com.salesforce.android.chat.core.model.ChatSessionInfo;
import com.salesforce.android.chat.core.model.ChatSessionState;
import com.salesforce.android.chat.ui.ChatUI;
import com.salesforce.android.chat.ui.ChatUIClient;
import com.salesforce.android.chat.ui.ChatUIConfiguration;
import com.salesforce.android.chat.ui.PreChatUIListener;
import com.salesforce.android.service.common.utilities.control.Async;

import java.lang.reflect.Field;

@ReactModule(name = SalesforceChatSdkModule.NAME)
public class SalesforceChatSdkModule extends ReactContextBaseJavaModule implements SessionStateListener, SessionInfoListener, PreChatUIListener {
  public static final String NAME = "SalesforceChatSdk";

  public SalesforceChatSdkModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }


  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
  public void startChat(ReadableMap chatConfig,
                        ReadableMap displayConfig,
                        ReadableMap backgroundConfig,
                        ReadableArray preChatDatas,
                        ReadableArray prechatEntitiesData, Promise promise) throws NoSuchFieldException, IllegalAccessException {

    ChatConfiguration chatConfiguration =
      new ChatConfiguration.Builder(chatConfig.getString("orgId"), chatConfig.getString("buttonId"),
        chatConfig.getString("deploymentId"), chatConfig.getString("liveAgentPod"))
        .build();
    ChatUIConfiguration uiConfig = new ChatUIConfiguration.Builder()
      .chatConfiguration(chatConfiguration)
      .defaultToMinimized(false)
      .build();
    Async.ResultHandler<? super ChatUIClient> resultHandler = new Async.ResultHandler<ChatUIClient>() {
      @Override
      public void handleResult(Async<?> operation, @NonNull final ChatUIClient chatUIClient) {
        chatUIClient.startChatSession(getCurrentActivity());
        chatUIClient.addSessionStateListener(SalesforceChatSdkModule.this);
        chatUIClient.addSessionInfoListener(SalesforceChatSdkModule.this);
        chatUIClient.addPreChatUIListener(SalesforceChatSdkModule.this);
        rewriteColor();
      }
    };
    ChatUI
      .configure(uiConfig)
      .createClient(getReactApplicationContext())
      .onResult(resultHandler);

  }
  public void rewriteColor()  {
  }
  @Override
  public void onSessionStateChange(ChatSessionState chatSessionState) {

  }

  @Override
  public void onSessionEnded(ChatEndReason chatEndReason) {

  }

  @Override
  public void onSessionInfoReceived(ChatSessionInfo chatSessionInfo) {

  }

  @Override
  public void onPreChatSubmitted() {

  }

  @Override
  public void onPreChatCancelled() {

  }
}
