init = ->
  myMap = new (ymaps.Map)('map',
    center: [
      55.76
      37.64
    ]
    zoom: 11)
  ymaps.behavior.storage.add 'mybehavior', MyBehavior
  myMap.behaviors.enable 'mybehavior'
  return

MyBehavior = ->
  @options = new (ymaps.option.Manager)
  @events = new (ymaps.event.Manager)
  return

ymaps.ready init
myMap = undefined
MyBehavior.prototype =
  constructor: MyBehavior
  enable: ->
    @_parent.getMap().events.add 'click', @_onClick, this
    return
  disable: ->
    @_parent.getMap().events.remove 'click', @_onClick, this
    return
  setParent: (parent) ->
    @_parent = parent
    return
  getParent: ->
    @_parent
  _onClick: (e) ->
    request = $.get '/maps/get_buildings',
      coords: e.get('coords'),
      (data)->
        $("#buildings").empty()
        $("#buildings").append data
        return