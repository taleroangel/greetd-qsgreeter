import QtQuick
import Quickshell

import qs.L10n
import qs.Theme

/**
 * Clock.qml
 * Show system clock
 */
Column {
	id: root

	/** Clock color */
	property alias color: clock.color

	/** Custom message to show above clock, if undefined or empty show date */
	property string message: ""

	/** Get curernt Date */
	function getDate() {
		return L10n.dateMessage + " " + Qt.formatDateTime(sys.date, L10n.dateFormat);
	}

	/** Get current Time */
	function getTime() {
		return Qt.formatDateTime(sys.date, Theme.style.clockLocale ? Qt.locale().timeFormat(Locale.ShortFormat) : "hh:mm");
	}

	SystemClock {
		id: sys
		precision: SystemClock.Minutes
	}

	Text {
		id: label
		text: (root.message == undefined || root.message == "") ? getDate() : root.message
		anchors.horizontalCenter: parent.horizontalCenter
		color: Theme.colors.surfaceContrast
		font.pixelSize: Theme.style.fontSizeParagraph
		font.family: Theme.style.fontFamilyParagraph
	}

	Text {
		id: clock
		text: getTime()
		anchors.horizontalCenter: parent.horizontalCenter
		color: Theme.colors.primary
		font.pixelSize: Theme.style.fontSizeHeading
		font.bold: true
		font.family: Theme.style.fontFamilyHeading
	}

	/* Animation for message change */
	Behavior on message {
		SequentialAnimation {
			NumberAnimation {
				target: label
				property: "opacity"
				to: 0.0
				duration: Theme.style.animationSpeedShort
			}

			PropertyAction {
				target: root
				property: "message"
			}

			NumberAnimation {
				target: label
				property: "opacity"
				to: 1.0
				duration: Theme.style.animationSpeedShort
			}
		}
	}
}
