import QtQuick
import QtQuick.Controls

import qs.Theme

Button {
	id: root

	required property string userName
	required property string realName
	required property string iconPath

	property ButtonColors theme: ButtonColors {}

	hoverEnabled: true

	background: Rectangle {
		id: background
		radius: (width / 2)
		color: theme.background.inactive

		Behavior on color {
			ColorAnimation {
				duration: Theme.style.animationSpeed
			}
		}

		Text {
			text: userName
			color: "white"
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
