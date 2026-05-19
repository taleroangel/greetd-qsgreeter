import QtQuick
import QtQuick.Controls

import qs.Theme
import qs.Animations

ComboBox {
	id: control
	model: sessionService.sessions

	padding: Theme.style.promptInputPadding

	background: InputBackground {
		selected: control.activeFocus
		border.color: control.activeFocus
			? Theme.colors.primary
			: Theme.colors.surfaceInactive
	}

	contentItem: Text {
		text: control.displayText
		font: control.font
		color: control.activeFocus
			? Theme.colors.primary
			: Theme.colors.surfaceInactive
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

		enter: PopupEnterTransition {}
		exit: PopupExitTransition {}
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
			color: delegate.highlighted ? Theme.colors.secondary : Theme.colors.surfaceContrast
		}
	}
}
