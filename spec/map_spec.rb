require_relative '../lib/rpextras'
require_relative '../lib/jruby_art/helper_methods'

Java::Monkstone::MathToolLibrary.new.load(JRuby.runtime, false)

include Processing::HelperMethods
include Processing::MathTool

EPSILON = 1.0e-04

describe 'map1d' do
  it 'should return map1d(x, range1, range2)' do
    x = 5
    range1 = (0..10)
    range2 = (100..1)
    expect(constrained_map(x, range1, range2)).to eq 50.5
  end
end 

describe 'map1d' do
  it 'should return map1d(x, range1, range2)' do
    x = 50
    range1 = (0..100)
    range2 = (0..1.0)
    expect(constrained_map(x, range1, range2)).to eq 0.5
  end
end

describe 'map1d' do
  it 'should return map1d(x, range1, range2)' do
    x = 7.5
    range1 = (0..10)
    range2 = (5..105)
    expect(constrained_map(x, range1, range2)).to eq 80.0
  end
end 

describe 'map1d' do
  it 'should return map1d(x, range1, range2)' do
    x = 0.7
    range1 = (0..1.0)
    range2 = (0..200)
    expect(constrained_map(x, range1, range2)).to eq 140
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


