require_relative '../lib/rpextras'

Java::ProcessingVecmathVec2::Vec2Library.new.load(JRuby.runtime, false)

EPSILON = 1.0e-04

describe 'Vec2D#to_a' do
  it 'should return x, y as an array' do
    x, y = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    expect(a.to_a).to eq([x, y])
  end
end

describe 'Vec2D#copy' do
  it 'should return a deep copy' do
    x, y = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    expect(a.copy.to_a).to eq([x, y])
  end
end

describe 'Vec2D#copy' do
  it 'should return a deep copy' do
    x, y = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    b = a.copy
    b *= 0
    expect(a.to_a).not_to eq(b.to_a)
  end
end

describe 'Vec2D#==' do
  it 'should return a == b' do
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    expect(a == b).to eq(false)
  end
end

describe 'Vec2D#==' do
  it 'should return a == b' do
    a = Vec2D.new(3.0000000, 5.00000)
    b = Vec2D.new(3.0000000, 5.000001)
    expect(a == b).to eq(true)
  end
end

describe 'Vec2D#+' do
  it 'should return Vec2D sum of a + b' do
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    expect(a + b).to eq Vec2D.new(9, 12)
  end
end

describe 'Vec2D#-' do
  it 'should return Vec2D sum of a - b' do
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    expect(a - b).to eq Vec2D.new(-3, -2)
  end
end


describe 'Vec2D#*' do
  it 'should return Vec2D sum of a * b' do
    a = Vec2D.new(3, 5)
    b = 2
    expect(a * b).to eq Vec2D.new(6, 10)
  end
end

describe 'Vec2D#from_angle' do
  it 'should return Vec2D.from_angle' do
    a = Vec2D.from_angle(Math::PI / 4.0)
    expect(a).to eq Vec2D.new(Math.sqrt(0.5), Math.sqrt(0.5))
  end
end

describe 'Vec2D#from_angle' do
  it 'should return Vec2D.from_angle' do
    a = Vec2D.from_angle(Math::PI * 0.75)
    expect(a).to eq Vec2D.new(-1 * Math.sqrt(0.5), Math.sqrt(0.5))
  end
end

describe 'Vec2D2#x=' do
  it 'should set x to supplied value' do
    a = Vec2D.new(3, 5)
    a.x=23
    expect(a.x).to eq 23.0
  end
end

describe 'Vec2D mag' do
  it 'should return Vec2D mag' do
    a = Vec2D.new(-3, -4)
    expect(a.mag).to eq 5
  end
end

describe 'Vec2D mag' do
  it 'should return Vec2D mag' do
    a = Vec2D.new(3.0, 2)
    expect(a.mag).to be_within(EPSILON).of(Math.sqrt(3.0**2 + 2**2))
  end
end

describe 'Vec2D mag' do
  it 'should return Vec2D dist' do
    a = Vec2D.new(3, 4)
    expect(a.mag).to eq(5)
  end
end

describe 'Vec2D mag' do
  it 'should return Vec2D dist' do
    a = Vec2D.new(-1, 0)
    expect(a.mag).to eq(1)
  end
end


describe 'Vec2D lerp' do
  it 'should return Vec2D lerp' do
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    expect(a.lerp(b, 0.5)).to eq Vec2D.new(2, 2)
  end
end

describe 'Vec2D lerp' do
  it 'should return Vec2D lerp' do
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    expect(a.lerp(b, 5)).to eq Vec2D.new(11, 11)
  end
end

describe 'Vec2D lerp!' do
  it 'should return Vec2D lerp!' do
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    a.lerp!(b, 0.5)
    expect(a).to eq Vec2D.new(2, 2)
  end
end

describe 'Vec2D lerp!' do
  it 'should return Vec2D lerp!' do
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    a.lerp!(b, -0.5)
    expect(a).to eq Vec2D.new(0, 0)
  end
end

describe 'Vec2D#set_mag' do
  it 'should return Vec2D#set_mag' do
    a = Vec2D.new(1, 1)
    expect(a.set_mag(Math.sqrt(32))).to eq Vec2D.new(4, 4)
  end
end

describe 'Vec2D#set_mag_block_false' do
  it 'should return Vec2D#set_mag' do
    a = Vec2D.new(1, 1)
    expect(a.set_mag(Math.sqrt(32)) { false }).to eq Vec2D.new(1, 1)
  end
end

describe 'Vec2D#set_mag_block_true' do
  it 'sho uld return Vec2D#set_mag' do
    a = Vec2D.new(1, 1)
    expect(a.set_mag(Math.sqrt(32)) { true }).to eq Vec2D.new(4, 4)
  end
end

describe 'Vec2D dist' do
  it 'should return a.dist(b)' do
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    expect(a.dist(b)).to eq Math.sqrt(3.0**2 + 2**2)
  end
end


describe 'Vec2D dot' do
  it 'should return Vec2D dist(a, b)' do
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    expect(a.dot(b)).to eq 53
  end
end

describe 'Vec2D #/' do
  it 'should return Vec2D sum of a * b' do
    a = Vec2D.new(6, 10)
    b = 2
    expect(a / b).to eq Vec2D.new(3, 5)
  end
end

describe 'Vec2D #+=' do
  it 'should return Vec2D result of a += b' do
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    a += b
    expect(a).to eq Vec2D.new(9, 12)
  end
end

describe 'Vec2D#normalize' do
  it 'should return Vec2D#normalize a new Vec2D with mag 1.0' do
    a = Vec2D.new(3, 5)
    b = a.normalize
    expect(b.mag).to be_within(EPSILON).of(1.0)
  end
end

describe 'Vec2D#normalize!' do
  it 'should return Vec2D#normalize! Vec2D#mag == 1.0' do
    a = Vec2D.new(3, 5)
    a.normalize!
    expect(a.mag).to be_within(EPSILON).of(1.0)
  end
end

describe 'Vec2D#heading' do
  it 'should return Vec2D#heading in radians' do
    a = Vec2D.new(1, 1)
    expect(a.heading).to be_within(EPSILON).of(Math::PI / 4.0)
  end
end

describe 'Vec2D#inspect' do
  it 'should return a String' do
    a = Vec2D.new(3, 2.000000000000001)
    expect(a.inspect).to eq 'Vec2D(x = 3.0000, y = 2.0000)'
  end
end

describe 'Vec2D#to_a' do
  it 'should return x, y as an array' do
    x, y = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    expect(a.to_a).to eq([x, y])
  end
end

describe 'Vec2D#array.reduce' do
  it 'should correctly sum objects of Vec2D' do
    array = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    sum = array.reduce(Vec2D.new) { |c, d| c + d }
    expect(sum).to eq(Vec2D.new(12, 6))
  end
end

describe 'Vec2D#array.zip(Vec2D#array)' do
  it 'should correctly zip arrays of Vec2D' do
    one = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    two = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    zipped = one.zip(two).flatten
    puts zipped
    expect(zipped).to eq([Vec2D.new(1, 2), Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(10, 2), Vec2D.new(1, 2), Vec2D.new(1, 2)])
  end
end

describe 'Vec2D#rotate rot' do
  it 'should return a rotated vector with same mag' do
    x, y = 20, 10
    b = Vec2D.new(x, y)
    a = b.rotate(Math::PI / 2)
    expect(a).to eq(Vec2D.new(-10.0, 20.0))
  end
end
