linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
path = require 'path'

class LinterRecess extends Linter
  # ConfigObserver.includeInto(this)

  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: 'source.css.less'

  # A string, list, tuple or callable that returns a string, list or tuple,
  # containing the command line (with arguments) used to lint.
  cmd: 'recess --format=compact --stripColors=true --noSummary=true' +
    ' --strictPropertyOrder=false --compile=false --compress=false'

  linterName: 'recess'

  # A regex pattern used to extract information from the executable's output.
  regex:
    '(?xi)' +
    '^.+?:' +                      # filename
    '(?<line>\\d+?|undefined):' +  # line
    '(?<message>.*)' +             # message
    '$'

  constructor: (editor)->
    super(editor)

    atom.config.observe 'linter-recess.recessExecutablePath', =>
      @executablePath = atom.config.get 'linter-recess.recessExecutablePath'

    console.log editor
    # if editor.getGrammar().scopeName is 'source.litcoffee'
    @cmd += ' --includePath="' + path.dirname(editor.getUri) + '"'

  destroy: ->
    atom.config.unobserve 'linter-recess.recessExecutablePath'

module.exports = LinterRecess
