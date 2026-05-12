/**
 * Apply properties from a json string into an object
 *
 * @param jsonString Json configuration as plain text
 * @param target QtObject to fill-in properties to
 */
function apply(jsonString, target) {
	const data = JSON.parse(jsonString)
	for (const k in data) {
		if (target.hasOwnProperty(k)) {
			target[k] = data[k]
		}
	}
}
