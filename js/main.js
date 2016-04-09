var Diff = require('diff');

swift_diffStrings = function(oldLine, newLine) {
	return Diff.diffWords(oldLine, newLine);
}
