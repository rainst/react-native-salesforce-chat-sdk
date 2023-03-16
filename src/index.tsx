import { NativeModules, Platform, NativeEventEmitter } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-salesforce-chat-sdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const SalesforceChatSdk = NativeModules.SalesforceChatSdk
  ? NativeModules.SalesforceChatSdk
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );
export function closeChat(): Promise<any> {
  return SalesforceChatSdk.closeChat();
}

export function onChatStateChangedListener(callback: (status: string) => void) {
  const emitter = new NativeEventEmitter(SalesforceChatSdk);
  const listener = emitter.addListener('onChatStateChanged', (data) => {
    callback(data);
  });
  return {
    remove: function remove() {
      listener.remove();
    },
  };
}

export function onChatEndListener(callback: (reason: string) => void) {
  const emitter = new NativeEventEmitter(SalesforceChatSdk);
  const listener = emitter.addListener('onChatEnd', (data) => {
    callback(data);
  });
  return {
    remove: function remove() {
      listener.remove();
    },
  };
}

export function onErrorListener(callback: (status: string) => void) {
  const emitter = new NativeEventEmitter(SalesforceChatSdk);
  const listener = emitter.addListener('onError', (data) => {
    callback(data);
  });
  return {
    remove: function remove() {
      listener.remove();
    },
  };
}

/**
 * @platform iOS only
 */
export function setAppearance(props: {
  navbarBackground?: string;
  navbarInverted?: string;
  brandPrimary?: string;
  brandSecondary?: string;
  brandPrimaryInverted?: string;
  brandSecondaryInverted?: string;
  contrastPrimary?: string;
  contrastSecondary?: string;
  contrastTertiary?: string;
  contrastQuaternary?: string;
  contrastInverted?: string;
  feedbackPrimary?: string;
  feedbackSecondary?: string;
  feedbackTertiary?: string;
  overlay?: string;
}): Promise<string> | null {
  if (Platform.OS === 'ios') {
    return SalesforceChatSdk.setAppearance(props);
  } else {
    console.warn('this function is not support this platform');
    return null;
  }
}

/**
 *
 *
 * @param displayConfig - iOS only
 * @param backgroundConfig - iOS only
 */
export function startChat(props: {
  chatConfig: {
    liveAgentPod: string;
    orgId: string;
    deploymentId: string;
    buttonId: string;
  };
  preChatDatas?: {
    initialValue?: string;
    autocapitalizationType?: number;
    autocorrectionType?: number;
    isRequired?: boolean;
    maxLength?: number;
    keyboardType?: number;
    label: string;
    fieldType: 'Object' | 'TextInput';
  }[];
  prechatEntitiesData?: PrechatEntitiy[];
  displayConfig?: {
    allowMinimization?: boolean;
    allowURLPreview?: boolean;
    defaultToMinimized?: boolean;
    showPreChat?: boolean;
    visitName?: string;
  };
  backgroundConfig?: {
    // iOS only
    allowBackgroundExecution?: boolean;
    allowBackgroundNotifications?: boolean;
  };
}): Promise<string> {
  return SalesforceChatSdk.startChat(
    props.chatConfig,
    props.displayConfig,
    props.backgroundConfig,
    props.preChatDatas,
    props.prechatEntitiesData
  );
}

export interface PrechatEntitiy {
  entityFieldMaps: EntityFieldMap[];
  entityName: string;
  saveToTranscript?: string;
  linkToEntityName?: string;
  linkToEntityField?: string;
}

export interface EntityFieldMap {
  doCreate: boolean;
  doFind: boolean;
  fieldName: string;
  isExactMatch: boolean;
  label: string;
}
