import QtQuick

import qs.Theme

/**
 * Placeholder.qml
 * Show a "dialog" like placeholder with text
 */
Rectangle {
	id: root

	required property string text
	property int padding: Theme.style.borderMargin
	property color backgroundColor: Theme.colors.primary
	property color foregroundColor: Theme.colors.primaryContrast

	width: child.implicitWidth + padding
	height: child.implicitHeight + padding
	radius: (padding / 2)

	color: root.backgroundColor

	Text {
		id: child
		anchors.centerIn: parent
		text: root.text
		color: root.foregroundColor
	}
}
