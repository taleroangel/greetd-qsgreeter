import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.Theme
import qs.L10n

import qs.Services as Services
import qs.Components as Components

FloatingWindow {

	title: "qsgreeter"
	color: "transparent"

	minimumSize: "600x400"

	/** Service for triggering poweroff/reboot */
	property Services.PowerService powerService: Services.PowerService {}

	/* Poweroff confirmation dialog */
	Components.ConfirmDialog {
		id: shutdownConfirm
		message: L10n.dialogShutdown

		onAccepted: {
			powerService.shutdown()
		}
	}

	/* Reboot confirmation dialog */
	Components.ConfirmDialog {
		id: rebootConfirm
		message: L10n.dialogReboot

		onAccepted: {
			powerService.reboot()
		}
	}

	Rectangle {
		anchors.fill: parent
		color: Theme.colors.surface

		radius: Theme.style.borderEnable ? Theme.style.borderRadius : 0
		border.color: Theme.style.borderEnable ? Theme.colors.primary : "transparent"
		border.width: Theme.style.borderEnable ? Theme.style.borderWidth : 0

		/* Top clock and welcome message */
		Components.Clock {
			id: clock
			anchors {
				top: parent.top
				topMargin: Theme.style.borderMargin
				horizontalCenter: parent.horizontalCenter
			}
		}

		/* User list and login prompt */
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

		/* Power buttons */
		Row {
			id: power
			anchors {
				bottom: parent.bottom
				bottomMargin: Theme.style.borderMargin
				horizontalCenter: parent.horizontalCenter
			}
			spacing: Theme.style.buttonSpacing

			/* Power-off button */
			Components.IconButton {
				source: Qt.resolvedUrl("Assets/power.svg")

				theme {
					background.hover: Theme.colors.error
					background.pressed: Theme.colors.errorContrast
					foreground.inactive: Theme.colors.error
					foreground.hover: Theme.colors.errorContrast
					foreground.pressed: Theme.colors.error
				}

				onClicked: {
					shutdownConfirm.open()
				}
			}

			/* Reboot button */
			Components.IconButton {
				source: Qt.resolvedUrl("Assets/reboot.svg")

				onClicked: {
					rebootConfirm.open()
				}
			}
		}
	}
}
