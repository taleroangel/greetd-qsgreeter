import QtQuick

import qs.Theme

/**
 * PopupEnterTransition.qml
 *
 * Enter transition for popup elements, (dialogs, comboboxes)
 */
Transition {
	NumberAnimation {
		property: "scale"
		easing: Easing.InQuad
		duration: Theme.style.animationSpeedShort
		from: (1 - Theme.style.animationBounce)
		to: 1.0
	}
	NumberAnimation {
		property: "opacity"
		duration: Theme.style.animationSpeedShort
		from: 0.0
		to: 1.0
	}
}
