import QtQuick
import QtQuick.Controls

import qs.Services
import qs.Theme

/**
 * UserSelection.qml
 *
 * Show an `UserList.qml` to choose an user, and then
 * show the `UserLogin.qml` for the selected user
 */
Item {
	id: root

	/** User object when selected, or undefined for displaying list of users */
	property var user: undefined

	/* List of users */
	Component {
		id: userList
		Item {
			UserList {
				anchors.centerIn: parent
				onSelected: function(user) {
					root.user = user;
					stack.push(userLogin);
				}
			}
		}
	}

	/* Password prompt for selected user */
	Component {
		id: userLogin
		Item {
			UserLogin {
				user: root.user
				anchors.centerIn: parent

				onCancel: {
					stack.pop();
				}

				Component.onDestruction: {
					root.user = undefined;
				}
			}
		}
	}

	StackView {
		id: stack
		initialItem: userList

		/* Animations */
		pushEnter: Transition {
			NumberAnimation {
				property: "opacity"
				easing.type: Easing.InQuint
				duration: Theme.style.animationSpeedLarge
				from: 0.0
				to: 1.0
			}

			NumberAnimation {
				property: "scale"
				easing.type: Easing.InCubic
				duration: Theme.style.animationSpeedLarge
				from: (1 - Theme.style.animationBounce)
				to: 1.0
			}
		}

		pushExit: Transition {
			NumberAnimation {
				property: "opacity"
				easing.type: Easing.OutQuint
				duration: Theme.style.animationSpeedLarge
				from: 1.0
				to: 0.0
			}
		}

		popExit: Transition {
			NumberAnimation {
				property: "opacity"
				easing.type: Easing.OutQuint
				duration: Theme.style.animationSpeedLarge
				from: 1.0
				to: 0.0
			}

			NumberAnimation {
				property: "scale"
				easing.type: Easing.OutCubic
				duration: Theme.style.animationSpeedLarge
				from: 1.0
				to: (1 - Theme.style.animationBounce)
			}
		}

		popEnter: Transition {
			NumberAnimation {
				property: "opacity"
				easing.type: Easing.InQuint
				duration: Theme.style.animationSpeedLarge
				from: 0.0
				to: 1.0
			}
		}
	}
}
