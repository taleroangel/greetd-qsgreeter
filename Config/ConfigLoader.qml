import QtQuick
import Quickshell
import Quickshell.Io

import "config.js" as Config

/**
 * ConfigLoader.qml
 * Load properties from a .json file into a QtObject type
 */
FileView {
	id: root

	property alias src: root.path
	property QtObject target

	preload: true
	blockLoading: true
	watchChanges: true

	onFileChanged: reload()
	onLoaded: Config.apply(text(), target)
}
