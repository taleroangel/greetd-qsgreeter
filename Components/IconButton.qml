import QtQuick
import QtQuick.Controls

import qs.Theme

/**
 * IconButton.qml
 * Round button to trigger an action, i.e PowerOff, Back, etc.
 */
CustomButton {
	id: root

	/** Image source URL */
	property alias source: root.icon.source

	implicitWidth: Theme.style.buttonSize
	implicitHeight: Theme.style.buttonSize

	display: AbstractButton.IconOnly
}
