pragma Singleton

import QtQuick
import Quickshell

import qs.Config

/**
 * Theme.qml
 * Global application theme
 */
Singleton {
	id: theme
	
	property Colorscheme colors: Colorscheme {}
	ConfigLoader {
		target: theme.colors
		src: "colorscheme.json"
	}

	property Style style: Style {}
	ConfigLoader {
		target: theme.style
		src: "style.json"
	}
}
