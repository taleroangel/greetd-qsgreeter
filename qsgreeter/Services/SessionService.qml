import QtQuick
import Quickshell
import Quickshell.Io

import "session_service_helper.js" as Helper

/**
 * pathservice.qml
 * List available Wayland paths for login
 */
QtObject {
	id: root

	/**
	 * List of session objects
	 *
	 * Object members:
	 *	- name {string} Display name of the session
	 *	- path {string} Path to the .desktop file
	 *	- props {object} .desktop file properties
	 */
	property var sessions: []

	/** List of Wayland session files */
	property var paths: []

	/** Process to load all session files */
	property Process _procListpaths: Process {
		id: proc
		command: ["ls", "-1", "/usr/share/wayland-sessions/"]
		stdout: SplitParser {
			onRead: function(data) {
				root.paths.push(`/usr/share/wayland-sessions/${data}`);
			}
		}

		onStarted: {
			root.sessions = [];
			root.paths = [];
		}

		onExited: {
			console.log("Found Wayland paths: " + root.paths);
			root.pathsChanged();
		}
	}

	/** Create workers that load the session files contents */
	property Instantiator _workerFactory: Instantiator {
		model: root.paths
		delegate: FileView {
			id: file
			path: Qt.resolvedUrl(modelData)
			preload: true

			onLoaded: {
				const obj = Helper.parseDesktopFile(file.text());
				console.log("Session successfully registered: " + obj["Name"]);
				sessions.push({
					name: obj["Name"] ?? "",
					path: modelData,
					props: obj
				});
				root.sessionsChanged();
			}
		}
	}

	/** Reload list of available wayland paths */
	function reload() {
		root._procListpaths.running = true
	}

	/* Automatically load list of paths */
	Component.onCompleted: {
		reload()
	}
}
