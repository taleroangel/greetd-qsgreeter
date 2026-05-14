/**
 * Returns the path to the JSON file based on system locale.
 * Defaults to "L10n/en.json" if the language isn't found or is "C".
 */
function getLocalePath() {
    let lang = Qt.locale().name.substring(0, 2);
    const supported = ["en", "es"];

    if (supported.indexOf(lang) !== -1) {
        return "L10n/" + lang + ".json";
    }

	// Fallback language
    return "L10n/en.json";
}
