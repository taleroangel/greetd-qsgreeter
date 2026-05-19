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
ColumnLayout {
	id: root

	/* User to show */
	required property var user

	/** When user cancels operation (back button) */
	signal cancel

	/** Function to get password prompt with username colored */
	function getUserPrompt(username) {
		const font = `<font color="${Theme.colors.primary}">${username}</font>`;
		return L10n.userPrompt.arg(font);
	}

	/** Currently selected session */
	property var session: undefined

	/** Message to show instead of name */
	property string message: ""

	/** Wrong password animation */
	property bool badPassword: false

	/** Service for triggering login */
	property LoginService loginService: LoginService {
		onMessage: function(message) {
			root.message = message;
		}

		onFailure: {
			root.badPassword = true
		}
	}

	/**
	 * Make a login attempt
	 *
	 * @param user {Object} org.freedesktop.Accounts.User -like object
	 * @param user.UserName {string} Linux user
	 * @param password {string} Password input text
	 * @param session {Object} .desktop file properties as key-value pairs
	 */
	function tryLogin(user: var, password: string, session: var) {
		loginService.login(user, password, session)
	}

	/** List Wayland sessions */
	property SessionService sessionService: SessionService {
		Component.onDestruction: {
			session = undefined;
		}
	}

	/** Message text */
	Text {
		text: (root.badPassword)
			? L10n.passwordError
			: (root.message != undefined && root.message != "") ? root.message : ""
		visible: root.badPassword || root.message != undefined && root.message != ""
		Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
		Layout.bottomMargin: Theme.style.accountSpacing

		color: Theme.colors.error
		font.family: Theme.style.fontFamilyParagraph
		font.pixelSize: Theme.style.fontSizeParagraph
	}

	RowLayout {
		Layout.alignment: Qt.AlignCenter
		spacing: Theme.style.accountSpacing

		/* Go Back Button */
		IconButton {
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
					color: root.badPassword ? Theme.colors.error : Theme.colors.primary

					background: InputBackground {
						selected: parent.activeFocus
						border.color: root.badPassword
							? Theme.colors.error
							: (passwordInput.activeFocus ? Theme.colors.primary : Theme.colors.surfaceInactive)
					}

					placeholderTextColor: activeFocus
						? Theme.colors.primary
						: (root.badPassword ? Theme.colors.error : Theme.colors.surfaceInactive)

					onActiveFocusChanged: {
						if (activeFocus) {
							root.badPassword = false;
						}
					}

					Keys.onPressed: (event) => {
						if (event.key === Qt.Key_Return) {
							// Get properties
							const user = root.user;
							const password = passwordInput.text;
							const session = root.session.props;

							// Start login attempt
							root.tryLogin(user, password, session);
							event.accepted = true;
						}
					}

					Component.onCompleted: {
						forceActiveFocus();
					}

					Behavior on color {
						ColorAnimation {
							duration: Theme.style.animationSpeedShort
						}
					}

					Behavior on placeholderTextColor {
						ColorAnimation {
							duration: Theme.style.animationSpeedShort
						}
					}
				}

				/* Login button */
				IconButton {
					Layout.maximumHeight: passwordInput.height
					radius: Theme.style.promptInputRadius
					source: Qt.resolvedUrl("../Assets/next.svg")
					onClicked: {
						// Get properties
						const user = root.user;
						const password = passwordInput.text;
						const session = root.session.props;

						// Start login attempt
						root.tryLogin(user, password, session);
					}
				}
			}

			/* Session picker */
			SessionPicker {
				id: sessionInput

				// `sessions` is an object, use property "name" for display
				model: sessionService.sessions
				textRole: "name"

				width: parent.width

				onCurrentIndexChanged: {
					root.session = model[currentIndex];
				}
			}
		}
	}
}
