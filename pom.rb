project 'jruby_art', 'https://github.com/ruby-processing/JRubyArt' do

  model_version '4.0.0'
  id 'ruby-processing:jruby_art:2.2.0'
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

  properties( 'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
              'source.directory' => 'src',
              'polyglot.dump.pom' => 'pom.xml',
              'project.build.sourceEncoding' => 'UTF-8',
              'jogl.version' => '2.3.2',
              'jruby.api' => 'http://jruby.org/apidocs/' )

  pom 'org.jruby:jruby:9.2.8.0'
  jar 'org.jogamp.jogl:jogl-all:${jogl.version}'
  jar 'org.jogamp.gluegen:gluegen-rt-main:${jogl.version}'
  jar 'org.processing:video:3.0.2'

  overrides do
    plugin :resources, '2.7'
    plugin :dependency, '2.8'
    plugin( :compiler, '3.8.1',
            'release' =>  '11' )
    plugin( :javadoc, '2.10.4',
            'detectOfflineLinks' =>  'false',
            'links' => [ '${processing.api}',
                         '${jruby.api}' ] )
    plugin( :jar, '3.1.1',
            'archive' => {
              'manifestEntries' => {
                'Class-Path' =>  'gluegen-rt.jar jog-all.jar'
              }
            } )
    plugin :jdeps, '3.1.2' do
      execute_goals 'jdkinternals', 'test-jdkinternals'
    end

  end


  build do

    resource do
      directory '${source.directory}/main/java'
      includes '**/**/*.glsl', '**/*.jnilib'
      excludes '**/**/*.java'
    end

    resource do
      directory '${source.directory}/main/resources'
      includes '**/*.png', '*.txt'
      excludes
    end
  end

end
