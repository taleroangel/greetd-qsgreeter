/**
 * Output from GDBUS call looks something like this:
 * `([objectpath '/org/freedesktop/Accounts/User1000'],)`
 *
 * This function parses those names into actual D-Bus
 * paths to gather user info
 *
 * @param {string} stdout `gdbus call` raw output
 * @returns {string[]} array of paths
 */
function parseUserList(stdout) {
	if (!stdout || typeof stdout !== "string") return [];
	const pathRegex = /'([^']+)'/g;
	const paths = [];
	let match;
	while ((match = pathRegex.exec(stdout)) !== null) {
		paths.push(match[1]);
	}
	return paths;
}

/**
 * Output from GDBUS call to user account is really messy
 * this function parses the output into a json object
 *
 * @param {string} stdout `gdbus call` raw ouput
 */
function parseUserData(stdout) {
	const user = {};

	// match 'Key': <value>
	const regex = /'([^']+)':\s+<([^>]+)>/g;
	let match;

	while ((match = regex.exec(stdout)) !== null) {
		const key = match[1];
		let val = match[2].trim();

		// Strings
		if (val.startsWith("'") && val.endsWith("'")) {
			user[key] = val.slice(1, -1);
		}
		// Booleans
		else if (val === "true" || val === "false") {
			user[key] = (val === "true");
		}
		// Numbers <uint64 1000>
		else if (/\d+/.test(val)) {
			const numMatch = val.match(/\d+/);
			user[key] = numMatch ? Number(numMatch[0]) : 0;
		}
		// Keep as string for fallback
		else {
			user[key] = val;
		}
	}

	return user;
}
