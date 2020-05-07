PlayerView = require './player-view'
{CompositeDisposable} = require 'atom'

module.exports = Mitsu =
  playerView: null
  subscriptions: new CompositeDisposable

  activate: (state) ->
    @playerView = new PlayerView(state.playerViewState)
    @subscriptions.add atom.workspace.addOpener (uri) =>
      return @playerView if uri == @playerView.getURI()

    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:toggle': => @playerView.toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:play-pause': => @playerView.togglePlayback()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:toggle-shuffle': => @playerView.toggleShuffle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:show-playlist': => @playerView.showPlayList()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:forward-15s': => @playerView.forward15()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:backward-15s': => @playerView.back15()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:next-track': => @playerView.nextTrack()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mitsu:previous-track': => @playerView.prevTrack()

  deactivate: ->
    @atomMusicView?.destroy()
    @subscriptions?.dispose()

  deserializePlayerView: (state) ->
    new PlayerView(state.playerViewState)

  serialize: ->
    deserializer: 'mitsu/PlayerView'
    playerViewState: @playerView.serialize()
