# JRubyArt

![Build Status](https://travis-ci.org/ruby-processing/JRubyArt.svg)


Is a development fork of [ruby-processing][], based on the latest development version of jruby-complete (9000-dev) and the latest stable version of [processing][]. As an exlusive linux user myself I am not able to support [ruby-processing][] on the Mac, without help from Mac users!!! The minimum java required is jdk7 (jdk8 preferred), and actually this is actually a requirement for processing-2.1.0+, and will very likeley be a minimum requirement for jruby-9000 (expected release summer 2014) which is what this development version is targetting. To avoid confusion with the original ruby-processing that development branch has been renamed to JRubyArt and the executable has been changed from `rp5` to `k9` (yes the same as the doctors canine companion). I have reverted to the default of using jruby-complete by default (mainly because it is easiers to keep track of jruby development that way). Currently vanilla processing development is unstable, working toward 3.0 release, you, can track the latest developments in [processing][] but it won't be worth testing it for for the foreseeable future. 

## Installation

You need to have vanilla processing installed and preferably the latest release of java-8 (that way my experiments with performance tuning stand a chance of making sense (detailed instructions to follow).

    `rake` to build and test

And then execute:

    `gem install jruby_art-{version}.gem`

You need to install jruby-complete to installed version:

    `install_jruby_dev`

You may if you wish use bundler, but for me it is a complete pain (it assumes too much, and you lose control). But if that is what you are used, to it makes sense to carry on using it.   

## Usage

`k9 run jwishy.rb`

[Contributing][]

[License][]

[Acknowledgements][]

 
[Acknowledgements]:ACKNOWLEDGEMENTS.md
[Contributing]:CONTRIBUTING.md
[License]:LICENSE.md
[processing]:https://github.com/processing/processing
[ruby-processing]:https://github.com/jashkenas/ruby-processing

