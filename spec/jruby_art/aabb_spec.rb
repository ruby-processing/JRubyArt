require_relative '../../lib/rpextras'
require_relative '../../lib/jruby_art/helpers/aabb'

Java::MonkstoneVecmathVec2::Vec2Library.new.load(JRuby.runtime, false)
Java::MonkstoneVecmathVec3::Vec3Library.new.load(JRuby.runtime, false)

EPSILON ||= 1.0e-04

describe 'AABB.new(center:, extent:)' do
  it 'should return a new instance' do
    x, y  = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    expect(AABB.new(center: Vec2D.new, extent: a)).to be_kind_of AABB
  end
end

describe 'AABB.from_min_max(min:, max:)' do
  it 'should return a new instance' do
    x0, y0  = -4, -4
    a = Vec2D.new(x0, y0)
    b = a *= -1
    expect(AABB.from_min_max(min: a, max: b)).to be_kind_of AABB
  end
end

describe 'AABB.from_min_max(min:, max:)' do
  it 'should return a new instance center 0, 0' do
    x0, y0  = -4, -4
    a = Vec2D.new(x0, y0)
    b = a * -1
    expect(AABB.from_min_max(min: a, max: b).center).to eq Vec2D.new
  end
end

describe 'aabb.position(vec)' do
  it 'should return new position' do
    x, y  = 1.0000001, 1.01
    a = AABB.new(center: Vec2D.new, extent: Vec2D.new(x, y))
    a.position(Vec2D.new(4, 6))
    expect(a.center).to eq Vec2D.new(4, 6)
  end
end

describe 'aabb.position(vec)' do
  it 'should return unchanged position' do
    x, y  = 1.0000001, 1.01
    a = AABB.new(center: Vec2D.new, extent: Vec2D.new(x, y))
    a.position(Vec2D.new(4, 6)) { false }
    expect(a.center).to eq Vec2D.new
  end
end

describe 'aabb.position(vec)' do
  it 'should return changed position' do
    x, y  = 1.0000001, 1.01
    a = AABB.new(center: Vec2D.new, extent: Vec2D.new(x, y))
    a.position(Vec2D.new(4, 6)) { true }
    expect(a.center).to eq Vec2D.new(4, 6)
  end
end

describe 'AABB.from_min_max' do
  it 'should return match' do
    x0, y0  = -4, -4
    x1, y1  = 4, 4
    a = Vec2D.new(x0, y0)
    b = Vec2D.new(x1, y1)
    expect(AABB.from_min_max(min: a, max: b).center).to eq Vec2D.new
  end
end

describe 'aabb.contains?' do
  it 'should return true' do
    x0, y0  = -4, -4
    a = Vec2D.new(x0, y0)
    b = AABB.from_min_max(min: a, max: a * -1)
    c = Vec2D.new(-3.99, 3.99)
    expect(b.contains?(c)).to be true
  end
end

describe 'aabb.contains?' do
  it 'should return false' do
    x0, y0  = -4, -4
    a = Vec2D.new(x0, y0)
    b = AABB.from_min_max(min: a, max: a * -1)
    c = Vec2D.new(-3.99, 4.01)
    expect(b.contains?(c)).to be false
  end
end

describe 'aabb.scale' do
  it 'should return changed extent' do
    x0, y0  = 4, 4
    a = Vec2D.new(x0, y0)
    b = AABB.new(center: Vec2D.new, extent: a)
    b.scale(2) 
    expect(b.extent).to eq a * 2
  end
end


  


