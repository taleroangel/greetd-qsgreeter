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
	property string userListError: "<l10n.userListError>"
	property string userWelcome: "<l10n.userWelcome(%1)>"

	ConfigLoader {
		target: l10n
		src: Locale.getLocalePath()
	}
}
