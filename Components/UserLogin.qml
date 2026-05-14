import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.Theme

/**
 * UserLogin.qml
 * Show the login screen (password and session) for a selected user
 */
RowLayout {
	id: root

	/* User to show */
	property var user: undefined

	/** When user cancels operation (back button) */
	signal cancel


	ActionButton {
		Layout.alignment: Qt.AlignVCenter

		source: Qt.resolvedUrl("../Assets/back.svg")
		theme.foreground.inactive: Theme.colors.surfaceContrast
		onClicked: {
			root.cancel();
		}
	}

	UserButton {
		Layout.alignment: Qt.AlignVCenter

		realName: user.RealName
		iconPath: user.IconFile
		enabled: false

		Layout.preferredWidth: Theme.style.accountSize
		Layout.preferredHeight: Theme.style.accountSize
	}
}
