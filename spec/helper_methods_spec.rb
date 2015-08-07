require_relative '../lib/jruby_art/helper_methods'
require_relative '../lib/core'

include Processing::HelperMethods

EPSILON = 1.0e-04

describe 'hexadecimal Fixnum color' do
  it 'should return color(hex)' do
    hexcolor = 0xFFCC6600
    expect(hex_color(hexcolor)).to eq -3381760
  end
end

describe 'hexadecimal String color' do
  it 'should return color(hex_string)' do
    hexstring = '#CC6600'
    expect(hex_color(hexstring)).to eq -3381760
  end
end

describe 'double color' do
  it 'should return color(double)' do
     col_double = 0.5
     expect(hex_color(col_double)).to eq 0.5
  end
end  

describe 'constrained_map included' do
  it 'should return constrained_map(x, range1, range2)' do
    x = 0
    range1 = (0..10)
    range2 = (100..1)
    expect(constrained_map(x, range1, range2)).to eq 100
  end
end

describe 'constrained_map reverse' do
  it 'should return constrained_map(x, range1, range2)' do
    x0 = 10.1
    x1 =  -2
    range1 = (0..10)
    range2 = (100..1)
    expect(constrained_map(x0, range1, range2)).to eq 1
    expect(constrained_map(x1, range1, range2)).to eq 100
  end
end

describe 'constrained_map forward' do
  it 'should return constrained_map(x, range1, range2)' do
    x0 = 10.1
    x1 =  -2
    range1 = (0..10)
    range2 = (1..100)
    expect(constrained_map(x0, range1, range2)).to eq 100
    expect(constrained_map(x1, range1, range2)).to eq 1
  end
end

describe '2D#dist' do
  it 'should return dist(ax, ay, ab, ay)' do
    ax, ay, bx, by = 0, 0, 1.0, 1.0
    expect(dist(ax, ay, bx, by)).to eq Math.sqrt(2)
  end
end

describe '2D#dist' do
  it 'should return dist(ax, ay, ab, ay)' do
    ax, ay, bx, by = 0, 0, 1.0, 0.0
    expect(dist(ax, ay, bx, by)).to eq 1.0
  end
end

describe '2D#dist' do
  it 'should return dist(ax, ay, ab, ay)' do
    ax, ay, bx, by = 0, 0, 0.0, 0.0
    expect(dist(ax, ay, bx, by)).to eq 0.0
  end
end

describe '2D#dist' do
  it 'should return dist(ax, ay, ab, ay)' do
    ax, ay, bx, by = 1, 1, -2.0, -3.0
    expect(dist(ax, ay, bx, by)).to eq 5
  end
end

describe '3D#dist' do
  it 'should return dist(ax, ay, ab, ay)' do
    ax, ay, bx, by, cx, cy = -1, -1, 100, 2.0, 3.0, 100
    expect(dist(ax, ay, bx, by, cx, cy)).to eq 5
  end
end

describe '3D#dist' do
  it 'should return dist(ax, ay, az, bx, by, bz)' do
    ax, ay, bx, by, cx, cy = 0, 0, -1.0, -1.0, 0, 0
    expect(dist(ax, ay, bx, by, cx, cy)).to eq Math.sqrt(2)
  end
end

describe '3D#dist' do
  it 'should return dist(ax, ay, az, bx, by, bz)' do
    ax, ay, bx, by, cx, cy = -1, -1, 0.0, 2.0, 3.0, 0
    expect(dist(ax, ay, bx, by, cx, cy)).to eq 5
  end
end

describe '3D#dist' do
  it 'should return dist(ax, ay, az, bx, by, bz)' do
    ax, ay, bx, by, cx, cy = 0, 0, 0.0, 0.0, 0, 0
    expect(dist(ax, ay, bx, by, cx, cy)).to eq 0.0
  end
end

describe '3D#dist' do
  it 'should return dist(ax, ay, az, bx, by, bz)' do
    ax, ay, bx, by, cx, cy = 0, 0, 1.0, 0.0, 0, 0
    expect(dist(ax, ay, bx, by, cx, cy)).to eq 1.0
  end
end

describe '3D#dist' do
  it 'should return dist(ax, ay, az, bx, by, bz)' do
    ax, ay, bx, by, cx, cy = 0, 0, 1.0, 1.0, 0, 0
    expect(dist(ax, ay, bx, by, cx, cy)).to eq Math.sqrt(2)
  end
end
