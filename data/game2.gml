if (!global.init) {

//LOAD SPRITES
globalvar sCarUp, sCarDown, sCarUpDead, sCarDownDead, sRacing, sRacingDead, sPolice, sPoliceDead, sGas;
var spr; spr = working_directory + "\data\sprites\"
sCarUp       = sprite_add(spr + "carup.png", 4, true, false, 0, 0)
sCarDown     = sprite_add(spr + "cardown.png", 4, true, false, 0, 0)
sCarUpDead   = sprite_add(spr + "carupdead.png", 4, true, false, 0, 0)
sCarDownDead = sprite_add(spr + "cardowndead.png", 4, true, false, 0, 0)
sRacing      = sprite_add(spr + "racing.png", 1, true, false, 0, 0)
sRacingDead  = sprite_add(spr + "racingdead.png", 1, true, false, 0, 0)
sPolice      = sprite_add(spr + "police.png", 6, true, false, 0, 0)
sPoliceDead  = sprite_add(spr + "policedead.png", 1, true, false, 0, 0)
sGas         = sprite_add(spr + "gas.png", 1, true, false, 0, 0)

//LOAD SOUNDS
globalvar aMusic, aHorn, aCollision, aSirens, aGas;
var snd; snd = working_directory + "\data\sounds\"
aMusic       = sound_add(snd + "music2.mid", 1, true)
aHorn        = sound_add(snd + "horn.wav", 0, true)
aCollision   = sound_add(snd + "collision.wav", 0, true)
aSirens      = sound_add(snd + "sirens.wav", 0, true)
aGas         = sound_add(snd + "gas_sound.wav", 0, true)

//LOAD BACKGROUNDS
globalvar bRoad;
var bg; bg   = working_directory + "\data\backgrounds\"
bRoad        = background_add(bg + "road.png", false, false)

//CREATE OBJECTS
globalvar CarRacing, CarDown, CarUp, Police, Gas, Controller, ControllerStart;
CarRacing       = object_add()
CarDown         = object_add()
CarUp           = object_add()
Police          = object_add()
Gas             = object_add()
Controller      = object_add()
ControllerStart = object_add()

//CarRacing
object_set_sprite(CarRacing, sRacing);
object_event_add(CarRacing, ev_create, 0, "
    dead = false
    vspeed = 0
")
object_event_add(CarRacing, ev_create, 0, "
    if dead exit
    if global.petrol <= 0 vspeed = 3
    global.petrol -= 1
")
object_event_add(CarRacing, ev_step, ev_step_normal, "
    if dead exit
    if global.petrol <= 0 vspeed = 3
    global.petrol -= 1
")
object_event_add(CarRacing, ev_collision, CarDown, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sRacingDead
    vspeed = 3
    dead = true
")
object_event_add(CarRacing, ev_collision, CarUp, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sRacingDead
    vspeed = 3
    dead = true
")
object_event_add(CarRacing, ev_collision, Police, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sRacingDead
    vspeed = 3
    dead = true
")
object_event_add(CarRacing, ev_collision, Gas, "
    if dead exit
    sound_play(aGas)
    global.petrol = min(1000, global.petrol+400)
    with other instance_destroy()
")
object_event_add(CarRacing, ev_step, ev_step_normal, "
    if keyboard_check(vk_space) if !sound_isplaying(aHorn) sound_play(aHorn)

    if global.petrol > 0 and !dead {
        if keyboard_check(vk_left) if x > 32 x -= 2
        if keyboard_check(vk_up) y -= 3
        if keyboard_check(vk_right) if x < 360 x += 2
        if keyboard_check(vk_down) y += 3
    }
")
object_event_add(CarRacing, ev_other, ev_outside, "
    sound_stop(aSirens)
    sleep(1000)
    lives -= 1
    room_restart()
")

//CarDown
object_set_sprite(CarDown, sCarDown)
object_event_add(CarDown, ev_create, 0, "
    dead = false
    image_index = random(4)
    image_speed = 0
    y = -80
    x = 44+120
    vspeed = 6
    if random(2) < 1 {
        x = 44+60
        vspeed = 5
        if random(3) < 1 {
            x = 44
            vspeed = 4
        }
    }
    if place_meeting(x,y,CarDown) instance_destroy()
")
object_event_add(CarDown, ev_collision, CarDown, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sCarDownDead
    vspeed = 3
    dead = true
")
object_event_add(CarDown, ev_collision, CarRacing, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sCarDownDead
    vspeed = 3
    dead = true
")
object_event_add(CarDown, ev_collision, Police, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sCarDownDead
    vspeed = 3
    dead = true
")
object_event_add(CarDown, ev_other, ev_outside, "
    if y > room_height instance_destroy()
")

//CarUp
object_set_sprite(CarUp, sCarUp)
object_event_add(CarUp, ev_create, 0, "
    dead = false
    image_index = random(4)
    image_speed = 0
    y = -80
    x = 44+300
    vspeed = 2
    if random(2) < 1 {
        x = 44+240
        vspeed = 1
        if random(3) < 1 {
            x = 44+180
            vspeed = 0.5
        }
    }
    if place_meeting(x,y,CarUp) instance_destroy()
")
object_event_add(CarUp, ev_collision, CarUp, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sCarUpDead
    vspeed = 3
    dead = true
")
object_event_add(CarUp, ev_collision, CarRacing, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sCarUpDead
    vspeed = 3
    dead = true
")
object_event_add(CarUp, ev_collision, Police, "
    if dead exit
    sound_play(aCollision)
    sprite_index = sCarUpDead
    vspeed = 3
    dead = true
")
object_event_add(CarUp, ev_other, ev_outside, "
    if y > room_height instance_destroy()
")

//Police
object_set_sprite(Police, sPolice)
object_event_add(Police, ev_create, 0, "
    sound_loop(aSirens)
    dead = false
    vspeed = -1.5
    x = CarRacing.x
    y = room_height
    if place_meeting(x,y,CarRacing) or place_meeting(x,y,CarDown) or place_meeting(x,y,CarUp) instance_destroy()
")
object_event_add(Police, ev_destroy, 0, "
    sound_stop(aSirens)
")
object_event_add(Police, ev_step, ev_step_normal, "
    if dead exit
    if CarRacing.x < x and place_empty(x-8, y) x -= 2
    if CarRacing.x > x and place_empty(x+8, y) x += 2
")
object_event_add(Police, ev_collision, CarDown, "
    if dead exit
    sound_stop(aSirens)
    sprite_index = sPoliceDead
    vspeed = 3
    dead = true
")
object_event_add(Police, ev_collision, CarUp, "
    if dead exit
    sound_stop(aSirens)
    sprite_index = sPoliceDead
    vspeed = 3
    dead = true
")
object_event_add(Police, ev_collision, CarRacing, "
    if dead exit
    sound_stop(aSirens)
    sprite_index = sPoliceDead
    vspeed = 3
    dead = true
")
object_event_add(Police, ev_collision, Police, "
    if dead exit
    sound_stop(aSirens)
    sprite_index = sPoliceDead
    vspeed = 3
    dead = true
")
object_event_add(Police, ev_other, ev_outside, "
    if y < 0 or y > room_height+20 instance_destroy()
")

//Gas
object_set_sprite(Gas, sGas)
object_set_depth(Gas, 10)
object_event_add(Gas, ev_create, 0, "
    vspeed = background_vspeed[0]
")
object_event_add(Gas, ev_other, ev_outside, "
    if y > room_height instance_destroy()
")

//Controller
object_event_add(Controller, ev_create, 0, "
    global.petrol = 1000
    alarm[0] = 300
")
object_event_add(Controller, ev_alarm, 0, "
    instance_create(40+random(320), -40, Gas)
    alarm[0] = 300 + score/100
")
object_event_add(Controller, ev_step, ev_step_normal, "
    score += 1
    if random(70 - score/200) < 1 instance_create(x,y,CarDown)
    if random(200 - score/200) < 1 instance_create(x,y,CarUp)
    if score > 3000 and random(800 - score/30) < 1 and instance_number(Police) = 0 instance_create(x,y,Police)
")
object_event_add(Controller, ev_other, ev_no_more_lives, "
    highscore_set_background(bRoad)
    highscore_set_border(true)
    highscore_set_colors(c_black, c_red, c_yellow)
    highscore_show(score)
    global.restarted = true
    room_restart()
")
object_event_add(Controller, ev_draw, 0, "
    draw_set_halign = fa_left
    draw_set_color(c_white)
    draw_text(420, 20, 'Score: ' + string(score))
    draw_text(420, 50, 'Cars left: ' + string(lives))
    draw_text(420, 100, 'Petrol')
    draw_healthbar(480, 100, 480+100, 120, global.petrol/1000*100, c_black, c_red, c_green, 0, true, true)
")

//SETUP ROOM
room_set_background(room, 0, true, false, bRoad, 0, 0, false, true, 0, 3, 1)
room_speed = 40

//FINISH INITIALIZING
global.init = true
global.restarted = true
room_restart()
}

//RESET ONLY IF THERE ARE NO MORE LIVES
if (global.restarted) {
    if !sound_isplaying(aMusic) sound_loop(bMusic)
    score = 0
    lives = 3
    global.restarted = false
}

//SETUP INSTANCES
instance_create(0, 0, Controller)
instance_create(0, 0, CarDown)
instance_create(0, 0, CarUp)
instance_create(200, 240, CarRacing)