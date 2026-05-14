import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.Theme
import qs.Components as Components

FloatingWindow {
	title: "qsgreeter"
	color: "transparent"
	maximumSize: "1000x500"
	minimumSize: "600x300"

	Rectangle {
		anchors.fill: parent
		color: Theme.colors.surface
		radius: Theme.style.borderRadius

		border.color: Theme.colors.primary
		border.width: Theme.style.borderWidth

		Components.Clock {
			anchors.top: parent.top
			anchors.topMargin: Theme.style.borderMargin
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Components.UserList {
			anchors.centerIn: parent
		}

		Row {
			anchors.bottom: parent.bottom
			anchors.bottomMargin: Theme.style.borderMargin
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: Theme.style.buttonSpacing

			Components.PowerButton {
				source: Qt.resolvedUrl("Assets/power.svg")

				theme.background.hover: Theme.colors.error
				theme.background.pressed: Theme.colors.errorContrast

				theme.foreground.inactive: Theme.colors.error
				theme.foreground.hover: Theme.colors.errorContrast
				theme.foreground.pressed: Theme.colors.error
			}

			Components.PowerButton {
				source: Qt.resolvedUrl("Assets/reboot.svg")
				theme.foreground.inactive: Theme.colors.surfaceContrast
			}
		}
	}
}
