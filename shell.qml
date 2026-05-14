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

		radius: Theme.style.borderEnable ? Theme.style.borderRadius : 0
		border.color: Theme.style.borderEnable ? Theme.colors.primary : "transparent"
		border.width: Theme.style.borderEnable ? Theme.style.borderWidth : 0

		Components.Clock {
			anchors {
				top: parent.top
				topMargin: Theme.style.borderMargin
				horizontalCenter: parent.horizontalCenter
			}
		}

		Components.UserList {
			anchors.centerIn: parent

			onSelected: function(user) {
				console.log(JSON.stringify(user))
			}
		}

		Row {
			anchors {
				bottom: parent.bottom
				bottomMargin: Theme.style.borderMargin
				horizontalCenter: parent.horizontalCenter
			}
			spacing: Theme.style.buttonSpacing

			Components.PowerButton {
				source: Qt.resolvedUrl("Assets/power.svg")

				theme {
					background.hover: Theme.colors.error
					background.pressed: Theme.colors.errorContrast
					foreground.inactive: Theme.colors.error
					foreground.hover: Theme.colors.errorContrast
					foreground.pressed: Theme.colors.error
				}

				onClicked: {
					console.log("TODO: Poweroff");
				}
			}

			Components.PowerButton {
				source: Qt.resolvedUrl("Assets/reboot.svg")
				theme.foreground.inactive: Theme.colors.surfaceContrast

				onClicked: {
					console.log("TODO: Reboot");
				}
			}
		}
	}
}
