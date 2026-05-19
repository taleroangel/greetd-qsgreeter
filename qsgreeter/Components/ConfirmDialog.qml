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

	Column {
		anchors.fill: parent
		spacing: Theme.style.buttonSpacing

		/* Header Text */
		Rectangle {
			width: parent.width
			height: Theme.style.fontSizeParagraph

			color: "transparent"
			Text {
				anchors.centerIn: parent
				text: L10n.dialogConfirmAction
				color: Theme.colors.primary
				font.family: Theme.style.fontFamilyParagraph
				font.pixelSize: Theme.style.fontSizeParagraph
			}
		}

		/* Dialog Contents */
		Text {
			text: root.message
			color: Theme.colors.surfaceContrast
			font.family: Theme.style.fontFamilyParagraph
			font.pixelSize: Theme.style.fontSizeParagraph
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
					font.family: Theme.style.fontFamilyParagraph
					font.pixelSize: Theme.style.fontSizeParagraph
				}

				TextButton {
					text: L10n.dialogAccept
					onClicked: root.accept()
					font.family: Theme.style.fontFamilyParagraph
					font.pixelSize: Theme.style.fontSizeParagraph
				}
			}
		}
	}

	enter: PopupEnterTransition {}
	exit: PopupExitTransition {}
}
