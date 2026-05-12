import QtQuick

QtObject {
	property HoverColorscheme background: HoverColorscheme {
		inactive: Theme.colors.surfaceBright
		hover: Theme.colors.primary
		pressed: Theme.colors.primaryContrast
	}

	property HoverColorscheme foreground: HoverColorscheme {
		inactive: Theme.colors.primary
		hover: Theme.colors.primaryContrast
		pressed: Theme.colors.primary
	}
}

