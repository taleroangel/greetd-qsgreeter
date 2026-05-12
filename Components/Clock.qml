import QtQuick
import Quickshell

import qs.Theme

Column {
	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}

	Text {
		text: Qt.formatDateTime(clock.date, "yyyy-MM-dd")
		anchors.horizontalCenter: parent.horizontalCenter
		color: Theme.colors.surfaceContrast
	}

	Text {
		text: Qt.formatDateTime(clock.date, "hh:mm")
		anchors.horizontalCenter: parent.horizontalCenter
		color: Theme.colors.surfaceContrast
	}
}
