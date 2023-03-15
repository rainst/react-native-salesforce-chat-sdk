import * as React from 'react';

import { StyleSheet, View, Text, Pressable } from 'react-native';
import {
  setAppearance,
  startChat,
  onChatStateChangedListener,
  closeChat,
} from 'react-native-salesforce-chat-sdk';

export default function App() {
  const onPress = async () => {
    await setAppearance({
      navbarBackground: '#01EC7F',
      contrastPrimary: '#050505',
      brandSecondary: '#000000',
      brandPrimary: '#000000',
      brandPrimaryInverted: '#FBFBFB',
    });
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
          label: 'FirstName',
          autocapitalizationType: 0,
          autocorrectionType: 0,
          isRequired: false,
          keyboardType: 0,
          maxLength: 50,
        },
        {
          initialValue: 'Stretti',
          label: 'LastName',
          autocapitalizationType: 0,
          autocorrectionType: 0,
          isRequired: false,
          keyboardType: 0,
          maxLength: 50,
        },
        {
          initialValue: 'rstretti@gmail.com',
          label: 'Email',
          autocapitalizationType: 0,
          autocorrectionType: 0,
          isRequired: false,
          keyboardType: 0,
          maxLength: 50,
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
        },
      ],
      displayConfig: {
        defaultToMinimized: false,
        allowMinimization: true,
        allowURLPreview: true,
        showPreChat: true,
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
