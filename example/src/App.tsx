import * as React from 'react';

import { StyleSheet, View, Text, Pressable } from 'react-native';
import {
  startChat,
  closeChat,
  onChatStateChangedListener,
} from 'react-native-salesforce-chat-sdk';

export default function App() {
  React.useEffect(() => {
    onChatStateChangedListener((data) => {
      console.log(data);
    });
  }, []);
  const onPress = async () => {
    await startChat({
      chatConfig: {
        liveAgentPod: 'd.la2-c2-ukb.salesforceliveagent.com',
        buttonId: '5735j000000kLaS',
        deploymentId: '5725j000000kKxx',
        orgId: '00D5j000008blp2',
      },
      preChatDatas: [
        {
          initialValue: 'Renato',
          label: 'First Name',
          autocapitalizationType: 0,
          autocorrectionType: 0,
          isRequired: false,
          keyboardType: 0,
          maxLength: 50,
          fieldType: 'Object',
        },
        {
          initialValue: 'Stretti',
          label: 'Last Name',
          autocapitalizationType: 0,
          autocorrectionType: 0,
          isRequired: false,
          keyboardType: 0,
          maxLength: 50,
          fieldType: 'Object',
        },
        {
          initialValue: 'rstretti@gmail.com',
          label: 'Email',
          autocapitalizationType: 0,
          autocorrectionType: 0,
          isRequired: false,
          keyboardType: 0,
          maxLength: 50,
          fieldType: 'Object',
        },
      ],
      prechatEntitiesData: [
        {
          entityFieldMaps: [
            {
              doCreate: true,
              doFind: true,
              fieldName: 'LastName',
              isExactMatch: true,
              label: 'Last Name',
            },
            {
              doCreate: true,
              doFind: true,
              fieldName: 'FirstName',
              isExactMatch: true,
              label: 'First Name',
            },
            {
              doCreate: true,
              doFind: true,
              fieldName: 'Email',
              isExactMatch: true,
              label: 'Email',
            },
          ],
          entityName: 'Contact',
          linkToEntityField: 'ContactId',
          linkToEntityName: 'Case',
          saveToTranscript: 'ContactId',
        },
      ],
      displayConfig: {
        defaultToMinimized: false,
        allowMinimization: true,
        allowURLPreview: true,
        showPreChat: false,
        visitName: 'Renato Stretti',
      },
      backgroundConfig: {
        allowBackgroundExecution: true,
        allowBackgroundNotifications: true,
      },
    });
  };
  return (
    <View style={styles.container}>
      <Pressable
        onPress={onPress}
        style={{ backgroundColor: 'white', padding: 10 }}
      >
        <Text>Result</Text>
      </Pressable>
      <Pressable
        onPress={closeChat}
        style={{ backgroundColor: 'white', padding: 10 }}
      >
        <Text>Close Chat</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
