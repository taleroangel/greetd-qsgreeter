import QtQuick
import Quickshell

import qs.L10n
import qs.Theme

/**
 * Clock.qml
 * Show system clock
 */
Column {
	property alias color: clock.color

	SystemClock {
		id: sys
		precision: SystemClock.Minutes
	}

	Text {
		text: L10n.dateMessage + " " + Qt.formatDateTime(sys.date, L10n.dateFormat)
		anchors.horizontalCenter: parent.horizontalCenter

		color: Theme.colors.surfaceContrast
		font.pixelSize: Theme.style.fontSizeParagraph
		font.family: Theme.style.fontFamilyParagraph

	}

	Text {
		id: clock
		text: Qt.formatDateTime(sys.date, Theme.style.clockLocale ? Qt.locale().timeFormat(Locale.ShortFormat) : "hh:mm")
		
		anchors.horizontalCenter: parent.horizontalCenter
		color: Theme.colors.primary
		font.pixelSize: Theme.style.fontSizeHeading
		font.bold: true
		font.family: Theme.style.fontFamilyHeading
	}
}
