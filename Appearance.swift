//
//  Appearance.swift
//  React-native-salesforce-chat-sdk
//
//  Created by Alex on 15/3/2023.
//

import Foundation
class Appearance {
	var navbarBackground: String?
	var navbarInverted: String?
	var brandPrimary: String?
	var brandSecondary: String?
	var brandPrimaryInverted: String?
	var brandSecondaryInverted: String?
	var contrastPrimary: String?
	var contrastSecondary: String?
	var contrastTertiary: String?
	var contrastQuaternary: String?
	var contrastInverted: String?
	var feedbackPrimary: String?
	var feedbackSecondary: String?
	var feedbackTertiary: String?
	var overlay: String?
	
	init(dict: NSDictionary) {
		self.navbarBackground = dict["navbarBackground"] as? String
		self.navbarInverted = dict["navbarInverted"] as? String
		self.brandPrimary = dict["brandPrimary"] as? String
		self.brandSecondary = dict["brandSecondary"] as? String
		self.brandPrimaryInverted = dict["brandPrimaryInverted"] as? String
		self.brandSecondaryInverted = dict["brandSecondaryInverted"] as? String
		self.contrastPrimary = dict["contrastPrimary"] as? String
		self.contrastSecondary = dict["contrastSecondary"] as? String
		self.contrastTertiary = dict["contrastTertiary"] as? String
		self.contrastQuaternary = dict["contrastQuaternary"] as? String
		self.contrastInverted = dict["contrastInverted"] as? String
		self.feedbackPrimary = dict["feedbackPrimary"] as? String
		self.feedbackSecondary = dict["feedbackSecondary"] as? String
		self.feedbackTertiary = dict["feedbackTertiary"] as? String
		self.overlay = dict["overlay"] as? String
	}
}
