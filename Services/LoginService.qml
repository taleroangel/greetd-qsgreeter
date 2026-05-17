import QtQuick
import Quickshell
import Quickshell.Services.Greetd

/**
 * LoginService.qml
 * Service for managing login and launch
 */
QtObject {
	id: root

	property var _username: undefined
	property var _password: undefined
	property var _sessionExec: undefined

	/**
	 * Start a login attempt
	 *
	 * @param user {object} (org.freedesktop.Account) user object as key-value pairs
	 * @param password {string} String with password to use
	 * @param session {object} Session .desktop file as key-value pairs
	 */
	function login(user: var, password: string, session: var) {
		// Set internal variables
		root._username = user.UserName;
		root._password = password;
		root._sessionExec = session.Exec;
		// Create greetd session
		Greetd.createSession(root._username);
	}

	/** Clear internal state */
	function clear() {
		// Set internal state
		root._username = undefined;
		root._password = undefined;
		root._sessionExec = undefined;
		// Cancel session
		Greetd.cancelSession();
	}

	/** Issued when bad password is provided */
	signal failure()

	/** Greetd issued a message */
	signal message(message: string)

	/* Handle Greetd events */
	property Connections _greetdConnection: Connections {
		id: conn
		target: Greetd

		function onAuthMessage(message, error, responseRequired, echoResponse) {
			console.log(message);
			console.log(error);
			console.log(responseRequired);
			console.log(echoResponse);

			// Handle generic messages
			if (!error && !responseRequired && echoResponse) {
				root.message(message);
				root.clear();
			}

			// Handle password request
			else if (responseRequired && message.toLowerCase().includes("password")) {
				Greetd.respond(root._password);
			}
		}

		function onAuthFailure(_) {
			console.error("Authentication failed for " + root._username);
			root.clear();
			root.failure();
		}

		function onReadyToLaunch() {
			console.log("Launching session " + root._sessionExec);
			Greetd.launch([root._sessionExec]);
		}
	}
}
