import nimraylib_now

type Sprite* = ref object of RootObj
    position* : Vector2
    speed* : float
    texture* : Texture2D

proc NewSprite*(x : float, y : float, speed : float, path : string) : Sprite =
    var sprite = Sprite()
    sprite.position = Vector2()
    sprite.position.x = x
    sprite.position.y = y
    sprite.speed = speed
    sprite.texture = loadTexture(path)

    return sprite

method Clean*(self : Sprite) {.base.} =
    unloadTexture(self.texture)

method GetBoundingBox*(self : Sprite) : Rectangle {.base.} =
    var rect = Rectangle()
    rect.x = self.position.x
    rect.y = self.position.y
    rect.width = float(self.texture.width)
    rect.height = float(self.texture.height)
    return rect

method Collides*(self : Sprite, other : Rectangle) : bool {.base.} =
    return checkCollisionRecs(self.GetBoundingBox(), other)

method Update*(self : Sprite, delta : float) {.base.} =
    discard

method Draw*(self : Sprite) {.base.} =
    drawTexture(self.texture, cint(self.position.x), cint(self.position.y), White)

