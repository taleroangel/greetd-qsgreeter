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
	id: root

	UserService {
		id: userService

		Component.onCompleted: {
			reload()
		}
	}

	/** User was selected, pass user object as param */
	signal selected(user: var)

	states: [
		State {
			name: "busy"
			when: userService.busy
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
			duration: Theme.style.animationSpeedShort
			easing.type: Easing.InOutQuad
		}
	}

	/* Spin indicator */
	BusyIndicator {
		id: busyComponent
		anchors.centerIn: parent
		Layout.preferredWidth: Theme.style.accountSize
		Layout.preferredHeight: Theme.style.accountSize
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

				realName: modelData.RealName
				iconPath: modelData.IconFile

				Layout.preferredWidth: Theme.style.accountSize
				Layout.preferredHeight: Theme.style.accountSize

				onClicked: root.selected(modelData)
			}
		}
	}
}
