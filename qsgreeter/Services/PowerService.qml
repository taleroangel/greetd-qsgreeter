import QtQuick
import Quickshell
import Quickshell.Io

/**
 * PowerService.qml
 *
 * A class to manage shutdown/reboot
 */
QtObject {
	id: root

	/* Private process for shutdown */
	property Process _procShutdown: Process {
		command: [ "systemctl", "poweroff" ]
	}

	/* Private process for reboot */
	property Process _procReboot: Process {
		command: [ "systemctl", "reboot" ]
	}

	/** Start shutdown */
	function shutdown() {
		root._procShutdown.startDetached();
	}

	/** Start reboot */
	function reboot() {
		root._procReboot.startDetached();
	}
}
