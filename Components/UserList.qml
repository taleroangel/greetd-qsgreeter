import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

import qs.Theme
import qs.Services
import qs.L10n

/**
 * UserList.qml
 *
 * Use `UserService` to display list of users
 */
Item {
	width: parent.width
	height: Theme.style.accountSize

	UserService {
		id: userService

		Component.onCompleted: {
			reload()
		}
	}

	states: [
		State {
			name: "busy"
			when: userService.busy && !userService.ready
			PropertyChanges {
				target: busyComponent
				opacity: 1
			}
		},
		State {
			name: "error"
			when: !userService.busy && userService.error
			PropertyChanges {
				target: errorComponent
				opacity: 1
			}
		},
		State {
			name: "ready"
			when: !userService.busy && !userService.error && userService.ready
			PropertyChanges {
				target: usersComponent
				opacity: 1
			}
		},
	]

	transitions: Transition {
		NumberAnimation {
			property: "opacity"
			duration: Theme.style.animationSpeed
			easing.type: Easing.InOutQuad
		}
	}

	/* Spin indicator */
	BusyIndicator {
		id: busyComponent
		anchors.fill: parent
		opacity: 0
	}

	/* Error message */
	Placeholder {
		id: errorComponent
		anchors.centerIn: parent
		opacity: 0
		text: L10n.userListError
		padding: 40
	}

	/* Actual list of users */
	RowLayout {
		id: usersComponent
		anchors.centerIn: parent
		spacing: Theme.style.accountSpacing
		opacity: 0

		Repeater {
			id: repeater
			model: userService.users
			delegate: UserButton {
				required property var modelData

				userName: modelData.UserName
				realName: modelData.RealName
				iconPath: modelData.IconFile
			}
		}
	}
}
