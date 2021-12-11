if (!global.init) {

//LOAD SPRITES
globalvar
sMyPlane sLife sBottom
sIsland1 sIsland2 sIsland3
sEnemy1 sEnemy2 sEnemy3 sEnemy4 
sBullet sEnemyBullet1 sEnemyBullet2
sExplosion1 sExplosion2;

var spr; spr  = working_directory + "\data\sprites\"
sMyPlane      = sprite_add(spr + "myplane.png", 3, true, false, 32, 32)
sLife         = sprite_add(spr + "life.png", 1, true, false, 0, 0)
sBottom       = sprite_add(spr + "bottom.png", 1, false, false, 0, 0)
sIsland1      = sprite_add(spr + "island1.png", 1, true, false, 0, 0)
sIsland2      = sprite_add(spr + "island2.png", 1, true, false, 0, 0)
sIsland3      = sprite_add(spr + "island3.png", 1, true, false, 0, 0)
sEnemy1       = sprite_add(spr + "enemy1.png", 3, true, false, 16, 16)
sEnemy2       = sprite_add(spr + "enemy2.png", 3, true, false, 16, 16)
sEnemy3       = sprite_add(spr + "enemy3.png", 3, true, false, 16, 16)
sEnemy4       = sprite_add(spr + "enemy4.png", 3, true, false, 16, 16)
sBullet       = sprite_add(spr + "bullet.png", 1, true, false, 16, 16)
sEnemyBullet1 = sprite_add(spr + "enemybullet1.png", 1, true, false, 16, 16)
sEnemyBullet2 = sprite_add(spr + "enemybullet2.png", 1, true, false, 16, 16)
sExplosion1   = sprite_add(spr + "explosion1.png", 6, true, false, 16, 16)
sExplosion2   = sprite_add(spr + "explosion2.png", 7, true, false, 32, 32)

//LOAD SOUNDS
globalvar aExplosion1, aExplosion2 aMusic;
var snd; snd  = working_directory + "\data\sounds\"
aExplosion1   = sound_add(snd + "explosion1.wav", 0, true)
aExplosion2   = sound_add(snd + "explosion2.wav", 0, true)
aMusic        = sound_add(snd + "music.mid", 1, true)

//LOAD BACKGROUNDS
globalvar bWater, bScore;
var bg; bg    = working_directory + "\data\backgrounds\"
bWater        = background_add(bg + "water.png", false, false)
bScore        = background_add(bg + "score.png", false, false)

//CREATE OBJECTS
globalvar
MyPlane Island1 Island2 Island3
Enemy1 Enemy2 Enemy3 Enemy4
Bullet EnemyBullet1 EnemyBullet2
Explosion1 Explosion2
ControllerLife ControllerEnemy;

MyPlane         = object_add()
Island1         = object_add()
Island2         = object_add()
Island3         = object_add()
Enemy1          = object_add()
Enemy2          = object_add()
Enemy3          = object_add()
Enemy4          = object_add()
Bullet          = object_add()
EnemyBullet1    = object_add()
EnemyBullet2    = object_add()
Explosion1      = object_add()
Explosion2      = object_add()
ControllerLife  = object_add()
ControllerEnemy = object_add()

//MyPlane
object_set_sprite(MyPlane, sMyPlane)
object_set_depth(MyPlane, -100)
object_event_add(MyPlane, ev_create, 0, "
    can_shoot = true
")
object_event_add(MyPlane, ev_alarm, 0, "
    can_shoot = true
")
object_event_add(MyPlane, ev_keyboard, vk_space, "
    if can_shoot {
        if score > 400 {
            instance_create(x-24, y-8, Bullet)
            instance_create(x+24, y-8, Bullet)
            if score > 1000
                instance_create(x, y-48, Bullet)
        } else {
            instance_create(x, y-16, Bullet)
        }
        can_shoot = false
        alarm[0] = 15
    }
")
object_event_add(MyPlane, ev_keyboard, vk_left, "
    if x > 40 x -= 4
")
object_event_add(MyPlane, ev_keyboard, vk_up, "
    if y > 40 y -= 2
")
object_event_add(MyPlane, ev_keyboard, vk_right, "
    if x < room_width-40 x += 4
")
object_event_add(MyPlane, ev_keyboard, vk_down, "
    if y < room_height-120 y += 2
")

//Island1
object_set_sprite(Island1, sIsland1)
object_set_depth(Island1, 10000)
object_event_add(Island1, ev_create, 0, "vspeed = 2")
object_event_add(Island1, ev_step, ev_step_normal, "
    if y > room_height {
        x = random(room_width)
        y = -65
    }
")

//Island2
object_set_sprite(Island2, sIsland2)
object_set_depth(Island2, 10000)
object_set_parent(Island2, Island1)

//Island3
object_set_sprite(Island3, sIsland3)
object_set_depth(Island3, 10000)
object_set_parent(Island3, Island1)

//Enemy1
object_set_sprite(Enemy1, sEnemy1)
object_event_add(Enemy1, ev_create, 0, "vspeed = 4")
object_event_add(Enemy1, ev_step, ev_step_normal, "
    if y > room_height+32 {
        x = random(room_width)
        y = -16
    }
")
object_event_add(Enemy1, ev_collision, MyPlane, "
    sound_play(aExplosion1)
    instance_create(x, y, Explosion1)
    x = random(room_width)
    y = -16
    health -= 30
")
object_event_add(Enemy1, ev_collision, Bullet, "
    sound_play(aExplosion1)
    instance_destroy()
    instance_create(x, y, Explosion1)
    x = random(room_width)
    y = -16
    score += 5
")

//Enemy2
object_set_sprite(Enemy2, sEnemy2)
object_set_parent(Enemy2, Enemy1)
object_event_add(Enemy2, ev_step, ev_step_normal, "
    event_inherited()
    if random(30) < 1
        instance_create(x, y+16, EnemyBullet1)
")
object_event_add(Enemy2, ev_collision, Bullet, "
    event_inherited()
    score += 5
")

//Enemy3
object_set_sprite(Enemy3, sEnemy3)
object_set_parent(Enemy3, Enemy1)
object_event_add(Enemy3, ev_step, ev_step_normal, "
    event_inherited()
    if random(80) < 1
        instance_create(x, y+16, EnemyBullet2)
")
object_event_add(Enemy3, ev_collision, Bullet, "
    event_inherited()
    score += 15
")

//Enemy4
object_set_sprite(Enemy4, sEnemy4)
object_event_add(Enemy4, ev_create, 0, "vspeed = -4")
object_event_add(Enemy4, ev_step, ev_step_normal, "
    if y < -32 {
        x = random(room_width)
        y = room_height+16
    }
")
object_event_add(Enemy4, ev_collision, MyPlane, "
    sound_play(aExplosion1)
    instance_create(x, y, Explosion1)
    x = random(room_width)
    y = room_height+16
    health -= 30
")
object_event_add(Enemy4, ev_collision, Bullet, "
    sound_play(aExplosion1)
    with other instance_destroy()
    instance_create(x, y, Explosion1)
    x = random(room_width)
    y = room_height + 400
    score += 40
")

//Bullet
object_set_sprite(Bullet, sBullet)
object_event_add(Bullet, ev_Create, 0, "vspeed = -8")
object_event_add(Bullet, ev_step, ev_step_normal, "
    if y < -16 instance_destroy()
")
object_event_add(Bullet, ev_collision, Enemy1, "instance_destroy()")

//EnemyBullet1
object_set_sprite(EnemyBullet1, sEnemyBullet1)
object_event_add(EnemyBullet1, ev_create, 0, "vspeed = 8")
object_event_add(EnemyBullet1, ev_collision, MyPlane, "
    sound_play(aExplosion1)
    instance_destroy()
    health -= 5
")
object_event_add(EnemyBullet1, ev_other, ev_outside, "instance_destroy()")

//EnemyBullet2
object_set_sprite(EnemyBullet2, sEnemyBullet2)
object_event_add(EnemyBullet2, ev_create, 0, "
    if instance_exists(MyPlane) {
        direction = point_direction(x, y, MyPlane.x, MyPlane.y)
        speed = 8
    } else
        vspeed = 8
")
object_event_add(EnemyBullet2, ev_collision, MyPlane, "
    sound_play(aExplosion1)
    instance_destroy()
    health -= 5
")
object_event_add(EnemyBullet2, ev_other, ev_outside, "instance_destroy()")

//Explosion1
object_set_sprite(Explosion1, sExplosion1)
object_event_add(Explosion1, ev_other, ev_animation_end, "instance_destroy()")

//Explosion2
object_set_sprite(Explosion2, sExplosion2)
object_event_add(Explosion2, ev_other, ev_animation_end, "
    instance_destroy()
    sleep(1000)
    screen_redraw()
    instance_create(x, y, MyPlane)
    lives -= 1
")

//ControllerLife
object_set_depth(ControllerLife, -10000)
object_event_add(ControllerLife, ev_create, 0, "
    score = 0
    lives = 3
    health = 100
    if !sound_isplaying(aMusic) sound_loop(aMusic)
")
object_event_add(ControllerLife, ev_other, ev_no_more_lives, "
    highscore_set_background(bScore)
    highscore_set_border(false)
    highscore_set_colors(c_black, c_red, c_black)
    highscore_show(score)
    room_restart()
")
object_event_add(ControllerLife, ev_other, ev_no_more_health, "
    health = 100
    sound_play(aExplosion2)
    with MyPlane instance_change(Explosion2, false)
")
object_event_add(ControllerLife, ev_draw, 0, "
    draw_sprite(sBottom, 0, 0, 404)
    draw_text(180, 440, score)
    draw_healthbar(12, 449, 138, 459, health, 0, c_red, c_green, 0, true, true)
    for (i=0; i<=lives-1; i+=1) draw_sprite(sLife, 0, 16+(i*32), 410)
")

//ControllerEnemy
object_event_add(ControllerEnemy, ev_create, 0, "
    instance_create(random(room_width), -16, Enemy1)
    instance_create(random(room_width), -100, Enemy1)
    alarm[0] = 200
    alarm[1] = 1000
    alarm[2] = 2000
    alarm[3] = 3000
")
object_event_add(ControllerEnemy, ev_alarm, 0, "
    instance_create(random(room_width), -16, Enemy1)
    if instance_number(Enemy1) < 8 alarm[0] = 500
")
object_event_add(ControllerEnemy, ev_alarm, 1, "
    instance_create(random(room_width), -16, Enemy2)
    if instance_number(Enemy2) < 5 alarm[1] = 500
")
object_event_add(ControllerEnemy, ev_alarm, 2, "
    instance_create(random(room_width), -16, Enemy3)
    if instance_number(Enemy3) < 3 alarm[2] = 1000
")
object_event_add(ControllerEnemy, ev_alarm, 3, "
    instance_create(random(room_width), room_height+16, Enemy4)
    alarm[3] = 500
")

//SETUP ROOM
room_set_background(room, 0, true, false, bWater, 0, 0, true, true, 0, 2, 1)
room_set_width(room, 640)
room_set_height(room, 480)

//FINISH INITIALIZING
global.init = true
room_restart()
}

//SETUP INSTANCES
instance_create(320, 352, MyPlane)
instance_create(0, 0, ControllerLife)
instance_create(0, 0, ControllerEnemy)
instance_create(64, 176, Island1)
instance_create(352, 32, Island2)
instance_create(448, 432, Island3)