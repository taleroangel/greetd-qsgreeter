import QtQuick
import QtQuick.Controls

import qs.Theme

Button {
	id: root

	/** Image source URL */
	property alias source: root.icon.source

	/** Button colorscheme (inactive, hover, pressed) */
	property ButtonTheme theme: ButtonTheme {}

	width: Theme.props.buttonSize
	height: Theme.props.buttonSize
	display: AbstractButton.IconOnly
	hoverEnabled: true

	icon.color: root.theme.foreground.inactive
	background: Rectangle {
		id: background
		radius: width
		color: root.theme.background.inactive

		Behavior on color {
			ColorAnimation {
				duration: Theme.props.animationSpeed
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
			}
		},
	]

}
