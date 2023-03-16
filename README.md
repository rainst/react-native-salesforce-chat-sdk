# react-native-salesforce-chat-sdk

Salesforce Embedded Service Chat SDK

## Installation

```sh
npm install react-native-salesforce-chat-sdk
```

## Usage

### Start a new chat

```js
import { startChat } from 'react-native-salesforce-chat-sdk';

const chatConfig = {
  liveAgentPod: '',
  buttonId: '',
  deploymentId: '',
  orgId: '',
};

const preChatDatas = [];

const prechatEntitiesData = [];

const displayConfig = {};

const backgroundConfig = {};

const result = await startChat({
  chatConfig,
  preChatDatas,
  prechatEntitiesData,
  displayConfig,
  backgroundConfig,
});
```

### Close the chat

```js
import { closeChat } from 'react-native-salesforce-chat-sdk';

closeChat();
```

### Set Appearance(iOS only)

```js
import { setAppearance } from 'react-native-salesforce-chat-sdk';

setAppearance({
  navbarBackground: '#ffffff',
});
```

### Android Appearance

Please follow Salesforce's doc [instructions](https://developer.salesforce.com/docs/atlas.en-us.service_sdk_android.meta/service_sdk_android/android_customize_colors.htm)

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
