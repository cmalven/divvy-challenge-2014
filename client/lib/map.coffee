root = exports ? this
class root.Map
  
  minLat = 41.64428600000000
  minLng = -87.94010100000000
  maxLat = 42.0010653
  maxLng = -87.52366100000000

  markerPositions = [
    # {
    #   latitude: 41.966629,
    #   longitude: -87.631907
    # }
    # {
    #   latitude: 41.896374, 
    #   longitude: -87.602413
    # }
    # {
    #   latitude: 41.853411, 
    #   longitude: -87.606694
    # }
  ]

  constructor: (@options) ->
    @_init()

  _init: =>
    @_threeMapSetup()
    @_addEventListeners()
    @_renderPlane()
    @_update()

  _addEventListeners: =>
    # Listen for new trips to be added
    PubSub.subscribe('tripsUpdated', @_stationSetup)

    # Mouse Movement Listeners
    $(window).on 'mousemove', (evt) =>
      @mouseX = evt.pageX
      @mouseY = evt.pageY
    $(window).on 'mousedown', (evt) =>
      @mousedown = true
    $(window).on 'mouseup', (evt) =>
      @mousedown = false

  _update: =>
    @_renderStation()
    @_renderScene()
    requestAnimationFrame(@_update)

  _stationSetup: =>
    @stations = Stations.find({}, {sort: {latitude: 1}}).fetch()
    @stationBeingRendered = 0
    @_removeSceneItems()
    @_renderPlane()
    @_renderMarkers()
    #@_generateStations('tripsByToStation', 0.04, @threeScene.material2)

  _renderStation: =>
    # Stop if there aren't any stations or we've already rendered every station
    return unless @stations
    return if @stationBeingRendered is @stations.length - 1

    station = @stations[@stationBeingRendered]
    sizes = 0.04
    # All trips from this station contribute to the size
    numTripsForStation = Trips.find({from_station_name: station.name}).count()
    heightIncrement = 0.04
    height = 0.001 + heightIncrement * numTripsForStation
    geometry = new THREE.CubeGeometry(sizes, sizes, height)
    colorIndex = convertToRange(height, 0, 10, 0.08, 0.2)
    color = new THREE.Color(0x000000).setHSL(colorIndex, 0.8, 0.5)
    material = new THREE.MeshPhongMaterial( { color: color, specular: 0xffffff, shininess: 20, shading: THREE.FlatShading } )
    cube = new THREE.Mesh( geometry, material)
    cube.position.x = @_convertLng(station.longitude)
    cube.position.y = @_convertLat(station.latitude)
    cube.position.z = height / 2
    @threeScene.scene.add( cube )

    @stationBeingRendered++ 

  _renderMarkers: =>
    for marker in markerPositions
      geometry = new THREE.CubeGeometry(0.04, 0.04, 0.06)
      cube = new THREE.Mesh( geometry, @threeScene.material2 )
      cube.position.x = @_convertLng(marker.longitude)
      cube.position.y = @_convertLat(marker.latitude)
      cube.position.z = 0.06 / 2
      @threeScene.scene.add( cube )

  _convertLng: (lng) =>
    return convertToRange lng, minLng, maxLng, -19, 9

  _convertLat: (lat) =>
    return convertToRange lat, minLat, maxLat, -19.54, 9.68

  _removeSceneItems: =>
    children = @threeScene.scene.children
    for number in [children.length..0]
      child = @threeScene.scene.children[number]
      if child instanceof THREE.Mesh
        @threeScene.scene.remove(child)
  
  _renderPlane: =>
    imgRatio = 3.261655566
    w = 8.9
    h = w * imgRatio
    plane = new THREE.Mesh(new THREE.PlaneGeometry(w, h), @threeScene.planeMaterial)
    plane.overdraw = true
    plane.position.x = 4
    plane.position.y = -4.1
    @threeScene.scene.add(plane)

  _threeMapSetup: =>
    @threeScene = new ThreeMapScene()

  _renderScene: =>
    @_updateCameraPosition()
    @threeScene.renderer.render(@threeScene.scene, @threeScene.camera)

  _updateCameraPosition: =>
    cameraMinX = -4
    cameraMaxX = 4
    cameraMinY = 4
    cameraMaxY = -4
    cameraMaxZ = 4
    cameraMinZ = 12

    @threeScene.camera.position.x = convertToRange @mouseX, 0, $(window).width(), cameraMinX, cameraMaxX

    @threeScene.camera.position.y = convertToRange @mouseY, 0, $(window).height(), cameraMinY, cameraMaxY

    camPos = @threeScene.camera.position.z
    camDirection = 0
    if @mousedown and camPos > cameraMaxZ
      camDirection = -0.5
    else if camPos < cameraMinZ and not @mousedown
      camDirection = 0.5
    @threeScene.camera.position.z += camDirection
