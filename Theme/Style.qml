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
	property int fontSizeHeading: 45
	property int fontSizeParagraph: 14

	// When set to false, borders are not drawn, instead
	// task is delegated to compositor
	property bool borderEnable: true
	
	// Window Borders
	property int borderWidth: 3
	property int borderRadius: 20
	property int borderMargin: 25

	// Buttons
	property int buttonSize: 50
	property int buttonSpacing: 20

	// Spacing between account icons
	property int accountSpacing: 30
	// Size of the account icon
	property int accountSize: 120

	// Password Prompt
	property int promptSpacing: 5
	property int promptSize: 200
	property int promptInputPadding: 10
	property int promptInputRadius: 10
	
	// Animations
	property real animationBounce: 0.2
	property int animationSpeedShort: 150
	property int animationSpeedLarge: 300
}
