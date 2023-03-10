import nimraylib_now
import std/random

type TileData = ref object of RootObj
    x : int
    y : int

let grass = TileData(x: 2, y: 1)
let tree2 = TileData(x: 0, y: 1)
let house1 = TileData(x: 6, y: 0)
let house2 = TileData(x: 13, y: 1)
let tree1 = TileData(x: 0, y : 0)
let tree3 = TileData(x: 14, y : 2)

type Map* = ref object of RootObj
    speed* : float
    position* : Vector2
    tileset* : Texture2D
    width* : int
    height* : int
    tile_size* : int
    tiles* : seq[seq[TileData]]
    gameWidth : float
    gameHeight : float

proc NewMap*(tileSize : int) : Map =
    var map = Map()
    map.speed = 20
    map.tile_size = tileSize
    map.position = Vector2()
    map.position.x = 0
    map.position.y = 0
    map.tileset = loadTexture("res/tiles_new.png")

    return map

proc Generate*(self : Map, width : int, height : int, gw : float, gh : float) =
    randomize()
    self.width = width
    self.height = height
    self.gameWidth = gw
    self.gameHeight = gh
    var matrix : seq[seq[TileData]]
    var row : seq[TileData]

    matrix = newSeq[seq[TileData]]()

    for i in countup(0, width):
        row = newSeq[TileData]()
        matrix.add(row)
        matrix[i].add(newSeq[TileData](height))

    for i in countup(0, width-1):
        for j in countup(0, height-1):
            let t = rand(1000)
            if t > 990:
                matrix[i][j] = house1
            elif t > 980:
                matrix[i][j] = house2
            elif t > 966:
                matrix[i][j] = tree2
            elif t > 933:
                matrix[i][j] = tree1
            elif t > 900:
                matrix[i][j] = tree3
            else:
                matrix[i][j] = grass

    self.tiles = matrix

proc Update*(self : var Map, delta : float, otherMap : Map) =
    self.position.y += 1 * self.speed * delta

proc Draw*(self : Map) =
    for i in countup(0, self.width - 1):
        for j in countup(0, self.height - 1):
            var td = self.tiles[i][j]
            var src_rect = Rectangle()
            src_rect.x = float(td.x) * float(self.tile_size)
            src_rect.y = float(td.y) * float(self.tile_size)
            src_rect.width = float(self.tile_size)
            src_rect.height = float(self.tile_size)

            var dest_rect = Rectangle()
            dest_rect.x = self.position.x + float(i) * float(self.tile_size)
            dest_rect.y = self.position.y + float(j) * float(self.tile_size)
            dest_rect.width = float(self.tile_size)
            dest_rect.height = float(self.tile_size)

            drawTexturePro(self.tileset, src_rect, dest_rect, Vector2(x:0,y:0), 0f, White)
