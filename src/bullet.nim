import nimraylib_now
import sprite as Sprite

type Bullet* = ref object of Sprite
    alive* : bool

proc NewBullet*(x : float, y : float, speed : float, path : string) : Bullet =
    var bullet = Bullet()
    bullet.speed = speed
    bullet.alive = true
    bullet.position = Vector2()
    bullet.position.x = x
    bullet.position.y = y
    bullet.speed = speed
    bullet.texture = loadTexture(path)
    playSound(loadSound("res/fire.wav"))
    return bullet

proc Update*(self : var Bullet, delta : float) =
    self.position.y -= 1 * self.speed * delta
    if self.position.y <= -30:
        self.alive = false

type EnemyBullet* = ref object of Sprite
    alive* : bool
    gameHeight : float

proc NewEnemyBullet*(x : float, y : float, speed : float, path : string, gameHeight : float) : EnemyBullet =
    var bullet = EnemyBullet()
    bullet.speed = speed
    bullet.alive = true
    bullet.position = Vector2()
    bullet.position.x = x
    bullet.position.y = y
    bullet.speed = speed
    bullet.texture = loadTexture(path)
    playSound(loadSound("res/enemyFire.wav"))
    bullet.gameHeight = gameHeight
    return bullet

method Draw(self : EnemyBullet) =
    var rect = Rectangle()
    rect.x = 0
    rect.y = 0
    rect.width = float(self.texture.width)
    rect.height = -float(self.texture.height)
    drawTextureRec(self.texture, rect, self.position, White)

proc Update*(self : var EnemyBullet, delta : float) =
    self.position.y += 1 * self.speed * delta
    if self.position.y > self.gameHeight:
        self.alive = false
