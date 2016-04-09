var Diff = require('diff');

gtg_diffStrings = function(oldLine, newLine) {
	return Diff.diffWords(oldLine, newLine);
}
