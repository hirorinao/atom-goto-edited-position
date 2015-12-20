{CompositeDisposable} = require 'atom'

module.exports = GotoEditedPosition =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'goto-edited-position:go': => @go()

  deactivate: ->
    @subscriptions.dispose()

  go: ->
    editor = atom.workspace.getActiveTextEditor()
    # editor.avoidMergingSelections => editor.buffer.undo()
    if editor.buffer.undo()
      editor.buffer.redo()
      editor.getLastSelection().autoscroll()
