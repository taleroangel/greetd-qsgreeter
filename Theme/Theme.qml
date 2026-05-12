pragma Singleton

import QtQuick
import Quickshell

import qs.Config

Singleton {
	id: theme
	
	property Colorscheme colors: Colorscheme {}
	ConfigLoader {
		target: theme.colors
		src: "colorscheme.json"
	}

	property Properties props: Properties {}
	ConfigLoader {
		target: theme.props
		src: "properties.json"
	}
}
