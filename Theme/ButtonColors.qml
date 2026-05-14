import QtQuick

/**
 * ButtonColors.qml
 */
QtObject {
	property HoverColors background: HoverColors {
		inactive: Theme.colors.surfaceBright
		hover: Theme.colors.primary
		pressed: Theme.colors.primaryContrast
	}

	property HoverColors foreground: HoverColors {
		inactive: Theme.colors.primary
		hover: Theme.colors.primaryContrast
		pressed: Theme.colors.primary
	}
}

