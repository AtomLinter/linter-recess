path = require 'path'
LinterRecess = require "./linter-recess"

module.exports =
  configDefaults:
    recessExecutablePath: path.join __dirname, '..', 'node_modules', 'recess', 'bin'

  activate: ->
    console.log 'activate linter-recess'
