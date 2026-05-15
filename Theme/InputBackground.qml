import QtQuick

/**
 * InputBackground.qml
 * `background` properties for input fields
 */
Rectangle {
	id: root

	/** Use to highlight the background (textInput.activeFocus) */
	required property bool selected

	radius: Theme.style.promptInputRadius
	color: Theme.colors.surfaceBright
	border.width: 1
	border.color: root.selected? Theme.colors.primary : Theme.colors.surfaceBright

	Behavior on border.color {
		ColorAnimation {
			duration: Theme.style.animationSpeedShort
		}
	}
}
