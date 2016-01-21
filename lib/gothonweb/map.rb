module Map
$guesses = 0

  class Room
    attr_reader :name, :paths, :description

    def initialize(name, description)
      @name = name
      @description = description
      @paths = {}
    end

    def go(direction)
      if @paths[direction].respond_to?(:call)
      @paths[direction].call
      else
        @paths[direction]
      end
    end

    def add_paths(paths)
      @paths.update(paths)
    end
  end

  def Map::laser_armory_guess
    $guesses += 1
    if $guesses < 5
      WEAPON_ARMORY_GUESS
    else
      LASER_WEAPON_ARMORY_DEATH
    end
  end

  CENTRAL_CORRIDOR = Room.new("Central Corridor",
    "
    The Gothons of Planet Percal #25 have invaded your ship and destroyed
    your entire crew.  You are the last surviving member and your last
    mission is to get the neutron destruct bomb from the Weapons Armory,
    put it in the bridge, and blow the ship up after getting into an
    escape pod.

    You're running down the central corridor to the Weapons Armory when
    a Gothon jumps out, red scaly skin, dark grimy teeth, and evil clown costume
    flowing around his hate filled body.  He's blocking the door to the
    Armory and about to pull a weapon to blast you.
    ")


  LASER_WEAPON_ARMORY = Room.new("Laser Weapon Armory",
    "
    Lucky for you they made you learn Gothon insults in the academy.
    You tell the one Gothon joke you know:
    Lbhe zbgure vf fb sng, jura fur fvgf nebhaq gur ubhfr, fur fvgf nebhaq gur ubhfr.
    The Gothon stops, tries not to laugh, then busts out laughing and can't move.
    While he's laughing you run up and shoot him square in the head
    putting him down, then jump through the Weapon Armory door.

    You do a dive roll into the Weapon Armory, crouch and scan the room
    for more Gothons that might be hiding.  It's dead quiet, too quiet.
    You stand up and run to the far side of the room and find the
    neutron bomb in its container.  There's a keypad lock on the box
    and you need the code to get the bomb out.  Security is most likely
    pretty tight here, so you hope you get it right on the first try. You
    think you remember it's 4 numbers and starts with 01 but you can't
    remember the rest. The third number is greater than 2, but less than 6
    and imperial protocal states the last number will be 1 less than the 3rd.
    ")


  THE_BRIDGE = Room.new("The Bridge",
    "
    The container clicks open and the seal breaks, letting gas out.
    You grab the neutron bomb and run as fast as you can to the
    bridge where you must place it in the right spot.

    You burst onto the Bridge with the netron destruct bomb
    under your arm and surprise 5 Gothons who are trying to
    take control of the ship.  Each of them has an even uglier
    clown costume than the last.  They haven't pulled their
    weapons out yet, as they see the active bomb under your
    arm and don't want to set it off.
    ")


  ESCAPE_POD = Room.new("Escape Pod",
    "
    You point your blaster at the bomb under your arm
    and the Gothons put their hands up and start to sweat.
    You inch backward to the door, open it, and then carefully
    place the bomb on the floor, pointing your blaster at it.
    You then jump back through the door, punch the close button
    and blast the lock so the Gothons can't get out.
    Now that the bomb is placed you run to the escape pod to
    get off this tin can.

    You rush through the ship desperately trying to make it to
    the escape pod before the whole ship explodes.  It seems like
    hardly any Gothons are on the ship, so your run is clear of
    interference.  You get to the chamber with the escape pods, and
    now need to pick one to take.  Some of them could be damaged
    but you don't have time to look.  There's 5 pods, which one
    do you take?
    ")


  THE_END_WINNER = Room.new("The End",
    "
    You jump into pod 2 and hit the eject button.
    The pod easily slides out into space heading to
    the planet below.  As it flies to the planet, you look
    back and see your ship implode then explode like a
    bright star, taking out the Gothon ship at the same
    time.  You won!
    ")


  THE_END_LOSER = Room.new("The End",
    "
    You jump into a random pod and hit the eject button.
    The pod escapes out into the void of space, then
    implodes as the hull ruptures, crushing your body
    into jam jelly. That sucks, but atleast you can die
    with the knowledge that you destroyed the Gothon's
    that attacked your ship!
    "
    )
  CORRIDOR_HELP = Room.new("Help",
    "
    You can try to shoot, dodge, or get on the Gothon's good side by telling a joke.

    Type back to go back.
    ")
  WEAPON_ARMORY_GUESS = Room.new("BzzzZZZZT",
    "
    You have entered the wrong code.
    You only have so many guesses or else alarms will sound!
    Try again!
    ")

  WEAPON_ARMORY_GUESS.add_paths({
    '0132' => THE_BRIDGE,
    '*' => lambda { Map::laser_armory_guess }
    })

  CORRIDOR_HELP.add_paths({
    'back' => CENTRAL_CORRIDOR
    })


  ESCAPE_POD.add_paths({
    '2' => THE_END_WINNER,
    '*' => THE_END_LOSER
    })

  GENERIC_DEATH = Room.new("Death", "
    You freeze at the wrong time and can't figure out what to do. The Gothon's have
    no problem however and they quickly disentagrate you.
    ")

  THE_BRIDGE_DEATH = Room.new("Death",
    "
    You go to throw the bomb, but trip and drop it instead.
    The fall sets the bomb off and you briefly wonder: In terms of the amount of energy
    delivered to you're retina which would be the most?

    A supernova, seen from as far away as the Sun is from Earth

    or

    The detonation of the now dropped bomb?

    An interesting question to be sure, but one that you are now to dead to care about.
    ")

  LASER_WEAPON_ARMORY_DEATH = Room.new("Death",
    "
    Now this is super embarassing but you can't seem to remember the code. You
    push on however but keep guessing it wrong, thinking you almost got it.
    Alarms sound throughout the ship and before you know it Gothon's burst into the room
    and shoot you a whole bunch of times, causing death.
    ")

  CENTRAL_CORRIDOR_SHOOT_DEATH = Room.new("Death",
    "
    You try blasting the Gothon before he can blast you, but you suddenly realize as
    your shot misses that you wish you had paid more attention in weapons training
    class. Rather than allow you to get into a protracted fire fight, the universe
    decides to jam your gun. You can tell that this Gothon did not skip his weapons
    training class as the shot is pretty much perfect. You now have a nice hole right
    between your eyes, pity you're dead though, as it would have made a cool story at
    parties.
    ")

  CENTRAL_CORRIDOR_DODGE_DEATH = Room.new("Death",
    "
    You loved dodgeball in High School and were exceptionally good at it. Much to your
    dismay you discover that the corridor is much much smaller than a standard gym. You
    smash your face into the wall and black out temporarily only to come-to and see the
    Gothon leaning over you - it's sharp teeth glistening. The last thing you feel are
    those teeth biting into your flesh.
    ")

  THE_BRIDGE_HELP = Room.new("Help", "
    You can throw the bomb, or slowly place it.
    'bridge' to go back.
    ")

  THE_BRIDGE_HELP.add_paths({
    'bridge' => THE_BRIDGE
    })

  THE_BRIDGE.add_paths({
    '*' => GENERIC_DEATH,
    'throw the bomb' => THE_BRIDGE_DEATH,
    'throw bomb' => THE_BRIDGE_DEATH,
    'slowly place the bomb' => ESCAPE_POD,
    'slowly place bomb' => ESCAPE_POD,
    'help' => THE_BRIDGE_HELP
    })

  LASER_WEAPON_ARMORY.add_paths({
    '0132' => THE_BRIDGE,
    '*' => lambda { Map::laser_armory_guess }
    })

  CENTRAL_CORRIDOR.add_paths({
    'shoot' => CENTRAL_CORRIDOR_SHOOT_DEATH,
    'dodge' => CENTRAL_CORRIDOR_DODGE_DEATH,
    'tell a joke' => LASER_WEAPON_ARMORY,
    'tell joke' => LASER_WEAPON_ARMORY,
    'help' => CORRIDOR_HELP,
    '*' => GENERIC_DEATH
    })

  START = CENTRAL_CORRIDOR

  # A whitelist of allowed room names. We use this so that
  # bad people on the internet can't access random variables
  # with names.  You can use Test::constants and Kernel.const_get
  # too.
  ROOM_NAMES = {
    'CENTRAL_CORRIDOR' => CENTRAL_CORRIDOR,
    'LASER_WEAPON_ARMORY' => LASER_WEAPON_ARMORY,
    'THE_BRIDGE' => THE_BRIDGE,
    'ESCAPE_POD' => ESCAPE_POD,
    'THE_END_WINNER' => THE_END_WINNER,
    'THE_END_LOSER' => THE_END_LOSER,
    'START' => START,
    'CENTRAL_CORRIDOR_DEATH' => CENTRAL_CORRIDOR_SHOOT_DEATH,
    'THE_BRIDGE_DEATH' => THE_BRIDGE_DEATH,
    'CENTRAL_CORRIDOR_DODGE_DEATH' => CENTRAL_CORRIDOR_DODGE_DEATH,
    'GENERIC_DEATH' => GENERIC_DEATH,
    'LASER_WEAPON_ARMORY_DEATH' => LASER_WEAPON_ARMORY_DEATH,
    'BRIDGE_HELP' => THE_BRIDGE_HELP,
    'CORRIDOR_HELP' => CORRIDOR_HELP,
    'ARMORY_GUESS' => WEAPON_ARMORY_GUESS
    }

  def Map::load_room(session)
      # Given a session this will return the right room or nil
      return ROOM_NAMES[session[:room]]
  end

  def Map::save_room(session, room)
      # Store the room in the session for later, using its name
      session[:room] = ROOM_NAMES.key(room)
  end

end
