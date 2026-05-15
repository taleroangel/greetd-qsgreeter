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
	required property var user
	 
	/** When user cancels operation (back button) */
	signal cancel

	/**
	 * Make a login attempt, parameter `info` has the following schema:
	 *
	 * @see getLoginInfo()
	 * 
	 * user {Object} org.freedesktop.Accounts.User -like object
	 * user.UserName {string} Linux user
	 * password {string} Password input text
	 * session {Object} Selected wayland session information
	 * session.name {string} Display name for the sesssion
	 * session.path {string} System-path to the sessions's .desktop file
	 * session.props {Object} .desktop file properties as key-value pairs
	 */
	signal tryLogin(info: var)

	/** Function to get password prompt with username colored */
	function getUserPrompt(username) {
		const font = `<font color="${Theme.colors.primary}">${username}</font>`;
		return L10n.userPrompt.arg(font);
	}

	/** Get user login information into an object */
	function getLoginInfo() {
		return {
			"user": root.user,
			"password": passwordInput.text,
			"session": root.session
		}
	}

	/** Currently selected session */
	property var session: undefined

	/** List Wayland sessions */
	property SessionService sessionService: SessionService {
		Component.onDestruction: {
			session = undefined;
		}
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
					const info = getLoginInfo();
					root.tryLogin(info);
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
