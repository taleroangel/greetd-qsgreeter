import QtQuick
import QtQml.Models
import Quickshell
import Quickshell.Io

import "user_service_helper.js" as Helper

/**
 * UserService.qml
 * Service for gathering users and their information
 */
QtObject {
	id: root

	/* List of D-Bus user paths */
	property var paths: []

	/**
	 * Dynamic list of users
	 *
	 * Relevant Properties:
	 *	- Uid
	 *	- UserName
	 *	- RealName
	 *	- IconFile
	 */
	property var users: []

	property bool busy: true /**< Operations are pending */
	property bool ready: false /**< Users were loaded */
	property bool error: false /**< Unable to load users */

	/** Call org.freedesktop.Accounts#ListCachedUsers */
	property Process _procListCachedUsers: Process {
		id: proc
		command: [
			"gdbus", "call", "--system",
			"--dest", "org.freedesktop.Accounts",
			"--object-path", "/org/freedesktop/Accounts",
			"--method", "org.freedesktop.Accounts.ListCachedUsers"
		]
		stdout: StdioCollector {}
		onStarted: {
			console.log("Retrieving list of users from D-Bus");
			root.paths = [];
			root.users = [];
			root.busy = true;
			root.ready = false;
			root.error = false;
		}
		onExited: function(exitCode, exitStatus) {
			if (exitCode == 0) {
				/* Set path for each user and call Process */
				root.paths = Helper.parseUserList(proc.stdout.text);
				console.log("Listed users: " + root.paths);
			} else {
				console.error("Unable to retrieve user list from D-Bus");
				root.busy = false;
				root.error = true;
				root.usersChanged();
			}
		}
	}

	/** Call org.freedesktop.Accounts.User for each user */
	property Instantiator _workerFactory: Instantiator {
		model: root.paths
		delegate: Process {
			id: proc
			running: true
			command: [
				"gdbus", "call", "--system",
				"--dest", "org.freedesktop.Accounts",
				"--method", "org.freedesktop.DBus.Properties.GetAll",
				"org.freedesktop.Accounts.User",
				"--object-path", modelData
			]
			stdout: StdioCollector {}
			onExited: function(exitCode, exitStatus) {
				if (exitCode == 0) {
					/* Append user data to json list */
					const data = Helper.parseUserData(proc.stdout.text);
					root.users.push(data);
					/* Check if all users have been updated */
					if (root.users.length >= root.paths.length) {
						console.log(`Finished parsing of <${ root.users.length }> users`);
						root.busy = false;
						root.ready = true;
						root.error = false;
						root.usersChanged();
					}
				} else {
					console.error("Failed to retrieve data for path: " + modelData);
					root.busy = false;
					root.error = true;
					root.usersChanged();
				}
			}
		}
	}

	/** Reload list of available system users */
	function reload() {
		root._procListCachedUsers.running = true
	}

	/* Automatically load list of users */
	Component.onCompleted: {
		reload()
	}
}
