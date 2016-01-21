require "./lib/gothonweb/map.rb"
require "test/unit"
require 'rack/test'

class TestMap < Test::Unit::TestCase

  def a_room_is_created
    gold = Room.new("GoldRoom", "This room has gold in it you can grab. There's a door to the north.")
    assert_equal("GoldRoom", gold.name)
    assert_equal({}, gold.paths)
  end

  def room_paths_are_created
    center = Room.new("Center", "Test room in the center.")
    north = Room.new("North", "Test room in the north.")
    south = Room.new("South", "Test room in the south.")

    center.add_paths({'north' => north, 'south' => south})
    assert_equal(north, center.go('north'))
    assert_equal(south, center.go('south'))
  end

  def map
    start = Room.new("Start", "You can go west and down a hole.")
    west = Room.new("Trees", "There are trees here, you can go east.")
    down = Room.new("Dungeon", "It's dark down here, you can go up.")

    start.add_paths({'west' => west, 'down' => down})
    west.add_paths({'east' => start})
    down.add_paths({'up' => start})

    assert_equal(west, start.go('west'))
    assert_equal(start, start.go('west').go('east'))
    assert_equal(start, start.go('down').go('up'))
  end

  def test_gothon_game_map()
    assert_equal(Map::CENTRAL_CORRIDOR_SHOOT_DEATH, Map::START.go('shoot!'))
    assert_equal(Map::CENTRAL_CORRIDOR_DODGE_DEATH, Map::START.go('dodge!'))
    assert_equal(Map::THE_BRIDGE_DEATH, Map::THE_BRIDGE.go('throw the bomb'))
    assert_equal(Map::LASER_WEAPON_ARMORY_DEATH, Map::LASER_WEAPON_ARMORY.go('*'))

    room = Map::START.go('tell a joke')
    assert_equal(Map::LASER_WEAPON_ARMORY, room)

    room = Map::LASER_WEAPON_ARMORY.go('0132')
    assert_equal(Map::THE_BRIDGE, room)

    room = Map::THE_BRIDGE.go('slowly place the bomb')
    assert_equal(Map::ESCAPE_POD, room)

    room = Map::ESCAPE_POD.go('2')
    assert_equal(Map::THE_END_WINNER, room)

    room = Map::ESCAPE_POD.go('*')
    assert_equal(Map::THE_END_LOSER, room)
  end

  def test_session_loading()
    session = {}

    room = Map::load_room(session)
    assert_equal(room, nil)

    Map::save_room(session, Map::START)
    room = Map::load_room(session)
    assert_equal(room, Map::START)

    room = room.go('tell a joke')
    assert_equal(room, Map::LASER_WEAPON_ARMORY)

    Map::save_room(session, room)
    assert_equal(room, Map::LASER_WEAPON_ARMORY)
  end
end
