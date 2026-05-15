import QtQuick
import QtQuick.Controls

import qs.Theme
import qs.Animations
import qs.L10n

/**
 * ConfirmDialog.qml
 * Show a dialog to confirm an operation
 */
Dialog {
	id: root

	/** Message to show */
	required property string message

	anchors.centerIn: parent
	modal: true

	padding: Theme.style.buttonSpacing

	background: Rectangle {
		color: Theme.colors.surface
		radius: Theme.style.borderRadius
		border.width: Theme.style.borderWidth
		border.color: Theme.colors.primary
	}

	header: undefined
	footer: undefined

	Column {
		anchors.fill: parent
		spacing: Theme.style.buttonSpacing

		/* Header Text */
		Rectangle {
			width: parent.width
			height: childrenRect.height

			color: "transparent"
			Text {
				anchors.centerIn: parent
				text: L10n.dialogConfirmAction
				color: Theme.colors.primary
			}
		}

		/* Dialog Contents */
		Text {
			text: root.message
			color: Theme.colors.surfaceContrast
		}

		/* Buttons */
		Rectangle {
			width: parent.width
			height: childrenRect.height

			color: "transparent"
			Row {
				anchors.centerIn: parent
				spacing: Theme.style.buttonSpacing

				TextButton {
					text: L10n.dialogCancel
					onClicked: root.reject()
				}

				TextButton {
					text: L10n.dialogAccept
					onClicked: root.accept()
				}
			}
		}
	}

	enter: PopupEnterTransition {}
	exit: PopupExitTransition {}
}
