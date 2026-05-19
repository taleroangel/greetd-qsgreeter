import QtQuick
import QtQuick.Controls

import qs.Theme

/**
 * CustomButton.qml
 * Base style button for IconButton and TextButton
 */
Button {
	id: root

	/** Button colorscheme (inactive, hover, pressed) */
	property ButtonColors theme: ButtonColors {}

	/** Override default radius */
	property alias radius: background.radius

	hoverEnabled: true

	icon.color: root.theme.foreground.inactive
	palette.buttonText: root.theme.foreground.inactive

	background: Rectangle {
		id: background
		radius: (Math.max(root.height, root.width) / 2)
		color: root.theme.background.inactive

		Behavior on color {
			ColorAnimation {
				duration: Theme.style.animationSpeedShort
			}
		}
	}

	states: [
		State {
			name: "hover"
			when: root.hovered && !root.pressed

			PropertyChanges {
				target: background
				color: root.theme.background.hover
			}

			PropertyChanges {
				target: root
				icon.color: root.theme.foreground.hover
				palette.buttonText: root.theme.foreground.hover
			}
		},
		State {
			name: "pressed"
			when: root.hovered && root.pressed

			PropertyChanges {
				target: background
				color: root.theme.background.pressed
			}

			PropertyChanges {
				target: root
				icon.color: root.theme.foreground.pressed
				palette.buttonText: root.theme.foreground.pressed
			}
		},
	]

}
