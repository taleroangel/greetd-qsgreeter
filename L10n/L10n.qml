pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import qs.Config

import "locale.js" as Locale

/**
 * L10n.qml
 * Global localization strings
 */
Singleton {
	id: l10n

	property string dateMessage: "<l10n.dateMessage>"
	property string dateFormat: "<l10n.dateFormat>"
	property string dialogConfirmAction: "<l10n.dialogConfirmAction>"
	property string dialogAccept: "<l10n.dialogAccept>"
	property string dialogCancel: "<l10n.dialogCancel>"
	property string dialogShutdown: "<l10n.dialogShutdown>"
	property string dialogReboot: "<l10n.dialogReboot>"
	property string userListError: "<l10n.userListError>"
	property string userWelcome: "<l10n.userWelcome(%1)>"
	property string userPrompt: "<l10n.userPrompt(%1)>"
	property string passwordPlaceholder: "<l10n.passwordPlaceholder>"
	property string passwordError: "<l10n.passwordError>"

	ConfigLoader {
		target: l10n
		src: Quickshell.shellDir + "/" + Locale.getLocalePath()
	}
}
