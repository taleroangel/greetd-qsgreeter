import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.Theme
import qs.L10n
import qs.Components as Components

FloatingWindow {
	title: "qsgreeter"
	color: "transparent"
	maximumSize: "1000x500"
	minimumSize: "600x400"

	Rectangle {
		anchors.fill: parent
		color: Theme.colors.surface

		radius: Theme.style.borderEnable ? Theme.style.borderRadius : 0
		border.color: Theme.style.borderEnable ? Theme.colors.primary : "transparent"
		border.width: Theme.style.borderEnable ? Theme.style.borderWidth : 0

		Components.Clock {
			id: clock
			anchors {
				top: parent.top
				topMargin: Theme.style.borderMargin
				horizontalCenter: parent.horizontalCenter
			}
		}

		Components.UserSelection {
			id: users
			anchors.centerIn: parent
			/* Show either the date or a welcome message */
			onUserChanged: {
				clock.message = (users.user != undefined)
					? L10n.userWelcome.arg(users.user.RealName)
					: "";
			}
		}

		Row {
			id: power
			anchors {
				bottom: parent.bottom
				bottomMargin: Theme.style.borderMargin
				horizontalCenter: parent.horizontalCenter
			}
			spacing: Theme.style.buttonSpacing

			Components.ActionButton {
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

			Components.ActionButton {
				source: Qt.resolvedUrl("Assets/reboot.svg")
				onClicked: {
					console.log("TODO: Reboot");
				}
			}
		}
	}
}
