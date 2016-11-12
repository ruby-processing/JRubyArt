# frozen_string_literal: true
# Boids -- after Tom de Smedt.
# See his Python version: http://nodebox.net/code/index.php/Boids
# This is an example of how a pure-Ruby library can work. Original for
# ruby-processing Jeremy Ashkenas. Reworked, re-factored for JRubyArt 0.9+
# by Martin Prout, features forwardable, keyword args, Vec3D and Vec2D.
class Boid
  attr_reader :boids
  attr_accessor :vel, :pos, :is_perching, :perch_time
  def initialize(boids, pos)
    @boids, @flock = boids, boids
    @pos = pos
    @vel = Vec3D.new
    @is_perching = false
    @perch_time = 0.0
  end

  def cohesion(d:)
    # Boids gravitate towards the center of the flock,
    # Which is the averaged position of the rest of the boids.
    vect = Vec3D.new
    @boids.each do |boid|
      vect += boid.pos unless boid == self
    end
    count = @boids.length - 1.0
    vect /= count
    (vect - pos) / d
  end

  def separation(radius:)
    # Boids don't like to cuddle.
    vect = Vec3D.new
    @boids.each do |boid|
      if boid != self
        dv = pos - boid.pos
        vect += dv if dv.mag < radius
      end
    end
    vect
  end

  def alignment(d:)
    # Boids like to fly at the speed of traffic.
    vect = Vec3D.new
    @boids.each do |boid|
      vect += boid.vel if boid != self
    end
    count = @boids.length - 1.0
    vect /= count
    (vect - vel) / d
  end

  def limit(max:)
    # Tweet, Tweet! The boid police will bust you for breaking the speed limit.
    most = [vel.x.abs, vel.y.abs, vel.z.abs].max
    return if most < max
    scale = max / most.to_f
    @vel *= scale
  end

  def angle
    Vec2D.new(vel.x, vel.y).heading
  end

  def goal(target, d = 50.0)
    # Them boids is hungry.
    (target - pos) / d
  end
end

require 'forwardable'

# The Boids class
class Boids
  include Enumerable
  extend Forwardable
  def_delegators(:@boids, :reject, :<<, :each, :shuffle!, :length, :next)

  attr_reader :has_goal, :perch, :perch_tm, :perch_y

  def initialize
    @boids = []
  end

  def self.flock(n:, x:, y:, w:, h:)
    flock = Boids.new.setup(n, x, y, w, h)
    flock.reset_goal(Vec3D.new(w / 2, h / 2, 0))
  end

  def setup(n, x, y, w, h)
    n.times do
      dx, dy = rand(w), rand(h)
      z = rand(200.0)
      self << Boid.new(self, Vec3D.new(x + dx, y + dy, z))
    end
    @x, @y, @w, @h = x, y, w, h
    @scattered = false
    @scatter = 0.005
    @scatter_time = 50.0
    @scatter_i = 0.0
    @perch = 1.0 # Lower this number to divebomb.
    @perch_y = h
    @perch_tm = -> { 25.0 + rand(50.0) }
    @has_goal = false
    @flee = false
    @goal = Vec3D.new
    self
  end

  def scatter(chance = 0.005, frames = 50.0)
    @scatter = chance
    @scatter_time = frames
  end

  def no_scatter
    @scatter = 0.0
  end

  def perch(ground = nil, chance = 1.0, frames = nil)
    @perch_tm = frames.nil? ? -> { 25.0 + rand(50.0) } : frames
    @perch_y = ground.nil? ? @h : ground
    @perch = chance
  end

  def no_perch
    @perch = 0.0
  end

  def reset_goal(target)
    @has_goal = true
    @flee = false
    @goal = target
    self
  end

  def goal(target:, flee:)
    @has_goal = true
    @flee = flee
    @goal = target
    self
  end

  def no_goal
    @has_goal = false
  end

  def constrain
    # Put them boids in a cage.
    dx, dy = @w * 0.1, @h * 0.1
    each do |b|
      b.vel.x += rand(dx) if b.pos.x < @x - dx
      b.vel.y += rand(dy) if b.pos.y < @y - dy
      b.vel.x -= rand(dx) if b.pos.x > @x + @w + dx
      b.vel.y -= rand(dy) if b.pos.y > @y + @h + dy
      b.vel.z += 10.0 if b.pos.z < 0.0
      b.vel.z -= 10.0 if b.pos.z > 100.0
      next unless b.pos.y > perch_y && rand < perch
      b.pos.y = perch_y
      b.vel.y = b.vel.y.abs * -0.2
      b.is_perching = true
      b.perch_time = perch_tm.respond_to?(:call) ? perch_tm.call : perch_tm
    end
  end

  def update(goal: 20.0, limit: 30.0, **args)
    shuffled = args.fetch(:shuffled, true)
    cohesion = args.fetch(:cohesion, 100)
    separation = args.fetch(:separation, 10)
    alignment = args.fetch(:alignment, 5.0)
    # Just flutter, little boids ... just flutter away.
    # Shuffling keeps things flowing smooth.
    shuffle! if shuffled
    m1 = 1.0 # cohesion
    m2 = 1.0 # separation
    m3 = 1.0 # alignment
    m4 = 1.0 # goal
    @scattered = true if !@scattered && rand < @scatter
    if @scattered
      m1 = -m1
      m3 *= 0.25
      @scatter_i += 1.0
    end
    if @scatter_i >= @scatter_time
      @scattered = false
      @scatter_i = 0.0
    end
    m4 = 0.0 unless has_goal
    m4 = -m4 if @flee
    each do |b|
      if b.is_perching
        if b.perch_time > 0.0
          b.perch_time -= 1.0
          next
        else
          b.is_perching = false
        end
      end
      v1 = b.cohesion(d: cohesion)
      v2 = b.separation(radius: separation)
      v3 = b.alignment(d: alignment)
      v4 = b.goal(@goal, goal)
      # NB: vector must precede scalar in '*' operation below
      b.vel += (v1 * m1 + v2 * m2 + v3 * m3 + v4 * m4)
      b.limit(max: limit)
      b.pos += b.vel
    end
    constrain
  end
end
