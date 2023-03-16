package com.salesforcechatsdk;

import static com.facebook.react.bridge.UiThreadUtil.runOnUiThread;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.salesforce.android.chat.core.ChatConfiguration;
import com.salesforce.android.chat.core.SessionInfoListener;
import com.salesforce.android.chat.core.SessionStateListener;
import com.salesforce.android.chat.core.model.ChatEndReason;
import com.salesforce.android.chat.core.model.ChatEntity;
import com.salesforce.android.chat.core.model.ChatEntityField;
import com.salesforce.android.chat.core.model.ChatSessionInfo;
import com.salesforce.android.chat.core.model.ChatSessionState;
import com.salesforce.android.chat.core.model.ChatUserData;
import com.salesforce.android.chat.ui.ChatUI;
import com.salesforce.android.chat.ui.ChatUIClient;
import com.salesforce.android.chat.ui.ChatUIConfiguration;
import com.salesforce.android.chat.ui.PreChatUIListener;
import com.salesforce.android.chat.ui.model.PreChatTextInputField;
import com.salesforce.android.service.common.utilities.control.Async;

@ReactModule(name = SalesforceChatSdkModule.NAME)
public class SalesforceChatSdkModule extends ReactContextBaseJavaModule implements SessionStateListener, SessionInfoListener, PreChatUIListener {
  public static final String NAME = "SalesforceChatSdk";

  public SalesforceChatSdkModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  ChatUIClient mChatUIClient = null;
  Async<Boolean> mChatUISession = null;

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }


  @ReactMethod
  public void closeChat(Promise promise) {
    runOnUiThread(new Runnable() {
      @Override
      public void run() {
        mChatUIClient.endChatSession();
        mChatUIClient.addSessionStateListener(SalesforceChatSdkModule.this);
        mChatUIClient.addSessionInfoListener(SalesforceChatSdkModule.this);
        mChatUIClient.addPreChatUIListener(SalesforceChatSdkModule.this);
        promise.resolve("done");
      }
    });

  }


  @ReactMethod
  public void startChat(ReadableMap chatConfig,
                        ReadableMap displayConfig,
                        ReadableMap backgroundConfig,
                        ReadableArray preChatDatas,
                        ReadableArray prechatEntitiesData, Promise promise) throws NoSuchFieldException, IllegalAccessException {

    ChatConfiguration chatConfiguration =
      new ChatConfiguration.Builder(chatConfig.getString("orgId"), chatConfig.getString("buttonId"),
        chatConfig.getString("deploymentId"), chatConfig.getString("liveAgentPod"))
        .chatUserData(createPreChatData(preChatDatas))
        .chatEntities(createChatEntities(prechatEntitiesData))
        .visitorName(displayConfig.getString("visitName"))
        .build();


    ChatUIConfiguration uiConfig = new ChatUIConfiguration.Builder()
      .chatConfiguration(chatConfiguration)
      .defaultToMinimized(displayConfig.getBoolean("defaultToMinimized"))
      .allowBackgroundNotifications(backgroundConfig.getBoolean("allowBackgroundNotifications"))
      .disablePreChatView(!displayConfig.getBoolean("showPreChat"))
      .build();

    Async.ResultHandler<? super ChatUIClient> resultHandler = new Async.ResultHandler<ChatUIClient>() {
      @Override
      public void handleResult(Async<?> operation, @NonNull final ChatUIClient chatUIClient) {
        mChatUIClient = chatUIClient;
        chatUIClient.addSessionStateListener(SalesforceChatSdkModule.this);
        chatUIClient.addSessionInfoListener(SalesforceChatSdkModule.this);
        chatUIClient.addPreChatUIListener(SalesforceChatSdkModule.this);
        mChatUISession = chatUIClient.startChatSession(getCurrentActivity());
        promise.resolve("opened");
      }
    };

    ChatUI
      .configure(uiConfig)
      .createClient(getReactApplicationContext())
      .onResult(resultHandler);
  }

  public void addChatEntityFields(ReadableArray preChatEntity, ChatEntity.Builder entity) {
    for (int i = 0; i < preChatEntity.size(); i++) {
      ReadableMap element = preChatEntity.getMap(i);
      ChatEntityField field =
        new ChatEntityField.Builder().doFind(element.getBoolean("doFind"))
          .isExactMatch(element.getBoolean("isExactMatch"))
          .doCreate(element.getBoolean("doCreate"))
          .build(element.getString("fieldName"), new ChatUserData(element.getString("label")));
      entity.addChatEntityField(field);
    }
  }

  private void sendEvent(ReactContext reactContext,
                         String eventName,
                         @Nullable WritableMap params) {
    reactContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
      .emit(eventName, params);
  }


  public ChatEntity[] createChatEntities(ReadableArray preChatEntity) {
    ChatEntity[] result = new ChatEntity[preChatEntity.size()];
    for (int i = 0; i < preChatEntity.size(); i++) {
      ReadableMap element = preChatEntity.getMap(i);
      ChatEntity.Builder entity = new ChatEntity.Builder();
      entity.showOnCreate(true);
      if (i > 0) {
        entity.linkToAnotherSalesforceObject(result[i - 1], element.getString("linkToEntityField"));
      }
      entity.linkToTranscriptField(element.getString("saveToTranscript"));
      addChatEntityFields(element.getArray("entityFieldMaps"), entity);
      result[i] = entity.build(element.getString("entityName"));
    }
    return result;
  }

  public PreChatTextInputField[] createPreChatData(ReadableArray preChatDatas) {
    PreChatTextInputField[] result = new PreChatTextInputField[preChatDatas.size()];
    for (int i = 0; i < preChatDatas.size(); i++) {
      ReadableMap element = preChatDatas.getMap(i);
      PreChatTextInputField builder = new PreChatTextInputField.Builder()
        .required(element.getBoolean("isRequired"))
        .initialValue(element.getString("initialValue"))
        .maxValueLength(element.getInt("maxLength"))
        .build(element.getString("label"), element.getString("label"));
      result[i] = builder;
    }
    return result;
  }


  @Override
  public void onSessionStateChange(ChatSessionState chatSessionState) {
    WritableMap map = new WritableNativeMap();
    if (chatSessionState == ChatSessionState.Disconnected) {
      map.putString("status", "disconnected");
    } else if (chatSessionState == ChatSessionState.Ready) {
      map.putString("status", "ready");
    } else if (chatSessionState == ChatSessionState.Verification) {
      map.putString("status", "verification");
    } else if (chatSessionState == ChatSessionState.Initializing) {
      map.putString("status", "initializing");
    } else if (chatSessionState == ChatSessionState.Connecting) {
      map.putString("status", "connecting");
    } else if (chatSessionState == ChatSessionState.InQueue) {
      map.putString("status", "queued");
    } else if (chatSessionState == ChatSessionState.Ending) {
      map.putString("status", "ending");
    } else if (chatSessionState == ChatSessionState.Connected) {
      map.putString("status", "connected");
    }
    sendEvent(getReactApplicationContext(), "onChatStateChanged", map);

  }

  @Override
  public void onSessionEnded(ChatEndReason chatEndReason) {
    WritableMap map = new WritableNativeMap();
    if (chatEndReason == ChatEndReason.EndedByAgent) {
      map.putString("reason", "Ended By Agent");
    } else if (chatEndReason == ChatEndReason.NoAgentsAvailable) {
      map.putString("reason", "No Agents Available");
    } else if (chatEndReason == ChatEndReason.LiveAgentTimeout) {
      map.putString("reason", "Live Agent Timeout");
    } else if (chatEndReason == ChatEndReason.NetworkError) {
      map.putString("reason", "Network Error");
    } else if (chatEndReason == ChatEndReason.VerificationError) {
      map.putString("reason", "Verification Error");
    } else if (chatEndReason == ChatEndReason.Unknown) {
      map.putString("reason", "Unknown");
    }
    sendEvent(getReactApplicationContext(), "onChatEnd", map);
  }

  @Override
  public void onSessionInfoReceived(ChatSessionInfo chatSessionInfo) {

  }

  @Override
  public void onPreChatSubmitted() {
    WritableMap map = new WritableNativeMap();
    map.putString("status", "PreChat Submitted");
    sendEvent(getReactApplicationContext(), "onChatStateChanged", map);
  }

  @Override
  public void onPreChatCancelled() {
    WritableMap map = new WritableNativeMap();
    map.putString("reason", "PreChat cancelled");
    sendEvent(getReactApplicationContext(), "onChatEnd", map);
  }
}
