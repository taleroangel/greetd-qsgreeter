import QtQuick

import qs.Theme

/**
 * PopupExitTransition.qml
 *
 * Exit transition for popup elements: (dialogs, comboboxes)
 */
Transition {
	SequentialAnimation {
		NumberAnimation {
			property: "scale"
			easing: Easing.InQuad
			duration: (Theme.style.animationSpeedShort / 2)
			from: 1.0
			to: (1 + (Theme.style.animationBounce) / 2)
		}

		NumberAnimation {
			property: "scale"
			easing: Easing.OutQuad
			duration: (Theme.style.animationSpeedShort / 2)
			from: (1 + (Theme.style.animationBounce / 2))
			to: (1 - (Theme.style.animationBounce / 2))
		}
	}

	NumberAnimation {
		property: "opacity"
		duration: Theme.style.animationSpeedShort
		from: 1.0
		to: 0.0
	}
}
