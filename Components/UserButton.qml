import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import qs.Theme

Item {
	id: root

	required property string realName
	required property string iconPath

	/** Button is clicked */
	signal clicked

	property ButtonColors theme: ButtonColors {}

	/* Children */
	Rectangle {
		id: account
		anchors.fill: parent
		radius: (width / 2)
		color: root.theme.background.inactive

		/* Profile Image Fallback */
		Text {
			id: iconText
			text: root.realName[0]
			anchors.centerIn: parent
			color: root.theme.foreground.inactive
			font.pixelSize: (Math.min(parent.width, parent.height) / 2)
		}

		/* Profile Image */
		Rectangle {
			id: mask
			anchors.fill: parent
			width: height * 2
			radius: (width / 2)
			visible: false
		}

		Image {
			id: face
			source: iconPath
			asynchronous: true
			visible: false
		}

		MultiEffect {
			id: iconFace
			anchors.fill: parent
			source: ShaderEffectSource {
				sourceItem: face
			}
			maskEnabled: true
			maskSpreadAtMax: 1.0
			maskSpreadAtMin: 1.0
			maskThresholdMax: 1.0
			maskThresholdMin: 0.5
			maskSource: ShaderEffectSource {
				sourceItem: mask
			}
		}

		/* Animations */
		Behavior on color {
			ColorAnimation {
				duration: Theme.style.animationSpeed
			}
		}

		Behavior on scale {
			NumberAnimation {
				duration: 2 * Theme.style.animationSpeed
				easing.type: Easing.OutQuad
			}
		}
	}

	Text {
		id: username
		anchors {
			top: account.bottom
			horizontalCenter: root.horizontalCenter
			topMargin: Theme.style.fontSizeParagraph + (account.height * (account.scale - 1)) / 2
		}
		text: root.realName
		color: root.theme.foreground.inactive
	}

	/* Handle Mouse Events */
	HoverHandler {
		id: hover
	}

	TapHandler {
		id: tap
		onTapped: root.clicked()
	}

	/* States based on mouse movement */
	states: [
		State {
			name: "hover"
			when: hover.hovered && !tap.pressed

			PropertyChanges {
				target: account
				color: root.theme.background.hover
				scale: Theme.style.accountBounce
			}

			PropertyChanges {
				target: iconText
				color: root.theme.foreground.hover
			}
		},
		State {
			name: "pressed"
			when: hover.hovered && tap.pressed

			PropertyChanges {
				target: account
				color: root.theme.background.pressed
			}
		},
	]
}
