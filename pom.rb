project 'jruby_art', 'https://github.com/ruby-processing/JRubyArt' do

  model_version '4.0.0'
  id 'ruby-processing:jruby_art:2.0.0'
  packaging 'jar'

  description 'Jar for JRubyArt'

  developer 'monkstone' do
    name 'Martin Prout'
    email 'mamba2928@yahoo.co.uk'
    roles 'developer'
  end

  issue_management 'https://github.com/ruby-processing/JRubyArt/issues', 'Github'

  source_control( :url => 'https://github.com/ruby-processing/JRubyArt',
                  :connection => 'scm:git:git://github.com/ruby-processing/JRubyArt.git',
                  :developer_connection => 'scm:git:git@github.com/ruby-processing/JRubyArt.git' )

  properties(
    'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
    'polyglot.dump.pom' => 'pom.xml',
    'project.build.sourceEncoding' => 'UTF-8',
    'jogl.version' => '2.3.2',
    'jruby.api' => 'http://jruby.org/apidocs/'
   )

  pom 'org.jruby:jruby:9.2.7.0'
  jar 'org.jogamp.jogl:jogl-all:${jogl.version}'
  jar 'org.jogamp.gluegen:gluegen-rt-main:${jogl.version}'
  jar 'org.processing:video:3.0.2'

  overrides do
    plugin :resources, '2.6'
    plugin :dependency, '2.8'
    plugin( :compiler, '3.8.0',
            'release' =>  '11' )
    plugin( :javadoc, '2.10.4',
            'detectOfflineLinks' =>  'false',
            'links' => [ '${processing.api}',
                         '${jruby.api}' ] )
  end


  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'jruby_art'
  end

end
