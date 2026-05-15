import QtQuick
import QtQuick.Controls

import qs.Theme

ComboBox {
	id: control
	model: sessionService.sessions

	padding: Theme.style.promptInputPadding

	background: InputBackground {
		selected: control.activeFocus
	}

	contentItem: Text {
		text: control.displayText
		font: control.font
		color: Theme.colors.secondary
		verticalAlignment: Text.AlignVCenter
	}

	popup: Popup {
		id: popup
		y: (parent.height - 1)
		width: parent.width
		height: contentItem.implicitHeight + (parent.padding * 2)

		contentItem: ListView {
			clip: true
			implicitHeight: contentHeight
			model: control.popup.visible ? control.delegateModel : null
			currentIndex: control.highlightedIndex

			ScrollIndicator.vertical: ScrollIndicator { }
		}

		background: InputBackground {
			selected: true
		}

		enter: Transition {
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

		exit: Transition {
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
	}

	delegate: ItemDelegate {
		id: delegate

		required property var model
		required property int index

		highlighted: control.highlightedIndex === index
		width: control.width

		contentItem: Text {
			text: delegate.model[control.textRole]
			color: delegate.highlighted ? Theme.colors.secondaryContrast : Theme.colors.surfaceContrast
			verticalAlignment: Text.AlignVCenter
		}

		background: Rectangle {
			width: popup.width - (control.padding * 2)
			radius: popup.background.radius
			color: delegate.highlighted ? Theme.colors.secondary : "transparent"
		}
	}
}
