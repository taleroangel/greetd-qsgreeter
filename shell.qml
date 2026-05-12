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
		radius: Theme.props.borderRadius

		border.color: Theme.colors.primary
		border.width: Theme.props.borderWidth

		Column {
			anchors.fill: parent

			Components.Clock {
				anchors.top: parent.top
				anchors.topMargin: Theme.props.borderMargin
				anchors.horizontalCenter: parent.horizontalCenter
			}

			Row {
				anchors.centerIn: parent

				Rectangle {
					width: 70
					height: 70
					color: "yellow"
				}

				Rectangle {
					width: 70
					height: 70
					color: "green"
				}
			}

			Row {
				anchors.bottom: parent.bottom
				anchors.bottomMargin: Theme.props.borderMargin
				anchors.horizontalCenter: parent.horizontalCenter
				spacing: Theme.props.buttonSpacing

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
}
