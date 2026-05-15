import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.Theme
import qs.L10n
import qs.Services

/**
 * UserLogin.qml
 * Show the login screen (password and session) for a selected user
 */
RowLayout {
	id: root

	/* User to show */
	property var user: undefined

	/** When user cancels operation (back button) */
	signal cancel

	/** Function to get password prompt with username colored */
	function getUserPrompt(username) {
		const font = `<font color="${Theme.colors.primary}">${username}</font>`;
		return L10n.userPrompt.arg(font);
	}

	/** List Wayland sessions */
	SessionService {
		id: sessionService
	}

	spacing: Theme.style.accountSpacing

	/* Go Back Button */
	ActionButton {
		source: Qt.resolvedUrl("../Assets/back.svg")
		onClicked: {
			root.cancel();
		}
	}

	/* User Face Icon */
	UserButton {
		realName: (user != null) ? user.RealName : ""
		iconPath: (user != null) ? user.IconFile : ""
		enabled: false

		Layout.preferredWidth: Theme.style.accountSize
		Layout.preferredHeight: Theme.style.accountSize
	}

	/* Prompt */
	Column {
		width: Theme.style.promptSize
		spacing: Theme.style.promptSpacing

		Text {
			textFormat: Text.StyledText
			text: (user != null) ? root.getUserPrompt(user.UserName) : ""
			color: Theme.colors.surfaceContrast
			font.family: Theme.style.fontFamilyParagraph
			font.pixelSize: Theme.style.fontSizeParagraph
		}

		/* Password Prompt */
		RowLayout {
			width: parent.width
			spacing: Theme.style.promptSpacing

			/* Password Input Field */
			TextField {
				id: passwordInput
				Layout.fillWidth: true
				echoMode: TextInput.Password
				placeholderText: L10n.passwordPlaceholder
				padding: Theme.style.promptInputPadding
				background: InputBackground {
					selected: parent.activeFocus
				}
			}

			/* Login button */
			ActionButton {
				Layout.maximumHeight: passwordInput.height
				radius: Theme.style.promptInputRadius
				source: Qt.resolvedUrl("../Assets/next.svg")
				onClicked: {
					console.log("TODO: Try login");
				}
			}
		}

		/* Session picker */
		ComboBox {
			id: sessionInput
			model: sessionService.sessions

			width: parent.width
			padding: Theme.style.promptInputPadding

			textRole: "name"

			background: InputBackground {
				selected: parent.activeFocus
			}

			contentItem: Text {
				text: sessionInput.displayText
				font: sessionInput.font
				color: Theme.colors.secondary
				verticalAlignment: Text.AlignVCenter
			}

			popup: Popup {
				id: popup
				y: (parent.height - 1)
				width: parent.width
				height: contentItem.implicitHeight + (parent.padding * 2)

				contentItem: ListView {
					clip: true
					implicitHeight: contentHeight
					model: sessionInput.popup.visible ? sessionInput.delegateModel : null
					currentIndex: sessionInput.highlightedIndex

					ScrollIndicator.vertical: ScrollIndicator { }
				}

				background: InputBackground {
					selected: true
				}

				enter: Transition {
					NumberAnimation {
						property: "scale"
						easing: Easing.InQuad
						duration: Theme.style.animationSpeedShort
						from: (1 - Theme.style.animationBounce)
						to: 1.0
					}
					NumberAnimation {
						property: "opacity"
						duration: Theme.style.animationSpeedShort
						from: 0.0
						to: 1.0
					}
				}
				
				exit: Transition {
					SequentialAnimation {
						NumberAnimation {
							property: "scale"
							easing: Easing.InQuad
							duration: (Theme.style.animationSpeedShort / 2)
							from: 1.0
							to: (1 + (Theme.style.animationBounce) / 2)
						}

						NumberAnimation {
							property: "scale"
							easing: Easing.OutQuad
							duration: (Theme.style.animationSpeedShort / 2)
							from: (1 + (Theme.style.animationBounce / 2))
							to: (1 - (Theme.style.animationBounce / 2))
						}
					}
					
					NumberAnimation {
						property: "opacity"
						duration: Theme.style.animationSpeedShort
						from: 1.0
						to: 0.0
					}
				}
			}

			delegate: ItemDelegate {
				id: delegate

				required property var model
				required property int index

				highlighted: sessionInput.highlightedIndex === index
				width: sessionInput.width

				contentItem: Text {
					text: delegate.model[sessionInput.textRole]
					color: delegate.highlighted ? Theme.colors.secondaryContrast : Theme.colors.surfaceContrast
					verticalAlignment: Text.AlignVCenter
				}

				background: Rectangle {
					width: popup.width - (sessionInput.padding * 2)
					radius: popup.background.radius
					color: delegate.highlighted ? Theme.colors.secondary : "transparent"
				}
			}
		}
	}
}
