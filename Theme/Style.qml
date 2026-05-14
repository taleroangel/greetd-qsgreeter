import QtQuick

/** 
 * Style.qml
 * Styling properties from configuration file
 */
QtObject {
	// Use the locale for clock format, if false use 24 hrs format
	property bool clockLocale: true

	// Text
	property string fontFamilyHeading: "Noto Sans"
	property string fontFamilyParagraph: "Noto Sans"
	property int fontSizeHeading: 30
	property int fontSizeParagraph: 14

	// Window Borders
	property int borderWidth: 3
	property int borderRadius: 20
	property int borderMargin: 25

	// Buttons
	property int buttonSize: 50
	property int buttonSpacing: 20

	// Spacing between account icons
	property int accountSpacing: 25
	// Size of the account icon
	property int accountSize: 100
	
	// Animations
	property int animationSpeed: 150

}
