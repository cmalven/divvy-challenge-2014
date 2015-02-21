root = exports ? this

class root.ThreeMapScene
  constructor: (@options) ->
    threeScene =
      scene: new THREE.Scene()
      camera: new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 2000 )
      renderer: new THREE.WebGLRenderer( { antialias: true } )
      material2: new THREE.MeshPhongMaterial( { color: 0x4300af, specular: 0xffffff, shininess: 20, shading: THREE.FlatShading } )
      planeMaterial: new THREE.MeshBasicMaterial({
        map: THREE.ImageUtils.loadTexture('/images/coast.jpg')
      })

    threeScene.renderer.setSize( window.innerWidth, window.innerHeight )
    document.body.appendChild( threeScene.renderer.domElement )

    # Lights

    hemiLight = new THREE.HemisphereLight( 0xffffff, 0xffffff, 0.6 )
    hemiLight.color.setHSL( 0.1, 1, 0.6 )
    hemiLight.groundColor.setHSL( 0.095, 1, 0.75 )
    hemiLight.position.set( 0, 500, 0 )
    threeScene.scene.add( hemiLight )

    dirLight = new THREE.DirectionalLight( 0xffffff, 1 )
    dirLight.color.setHSL( 0.1, 1, 0.95 )
    dirLight.position.set( -1, 1.75, 1 )
    dirLight.position.multiplyScalar( 50 )
    threeScene.scene.add( dirLight )

    dirLight.castShadow = true

    dirLight.shadowMapWidth = 2048
    dirLight.shadowMapHeight = 2048

    d = 50

    dirLight.shadowCameraLeft = -d
    dirLight.shadowCameraRight = d
    dirLight.shadowCameraTop = d
    dirLight.shadowCameraBottom = -d

    dirLight.shadowCameraFar = 3500
    dirLight.shadowBias = -0.0001
    dirLight.shadowDarkness = 0.35
    #dirLight.shadowCameraVisible = true

    # Camera
    threeScene.camera.position.z = 12

    return threeScene