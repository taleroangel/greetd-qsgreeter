/**
 * Parse contents from a .desktop file
 *
 * @param contents {string} Plain text contents of the file
 * @return {Object} An object with the parsed key-value pairs (keys in camelCase)
 */
function parseDesktopFile(contents) {
	const result = {};
	if (!contents || typeof contents !== "string" || contents == "") {
		return result;
	}

	const lines = contents.split(/\r?\n/);
	const keyValueRegex = /^\s*([a-zA-Z0-9\-\[\]@_]+)\s*=\s*(.*)$/;

	for (let line of lines) {
		line = line.trim();

		// Skip comments or block start
		if (!line || line.startsWith("#") || line.startsWith("[")) {
			continue;
		}

		// Get Key=value pairs
		const match = line.match(keyValueRegex);
		if (!match) continue;

		// Parse key as camel case
		let key = match[1].trim();
		key = key[0].toLowerCase() + key.slice(1);
		const value = match[2].trim();

		// Insert value
		result[key] = value;
	}

	return result;
}
