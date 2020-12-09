# frozen_string_literal: true

project 'jruby_art', 'https://github.com/ruby-processing/JRubyArt' do
  model_version '4.0.0'
  id 'ruby-processing:jruby_art:2.4.2'
  packaging 'jar'

  description 'Jar for JRubyArt'

  {
    'monkstone' => 'Martin Prout', 'benfry' => 'Ben Fry',
    'REAS' => 'Casey Reas', 'codeanticode' => 'Andres Colubri'
  }.each do |key, value|
    developer key do
      name value
      roles 'developer'
    end
  end

  issue_management 'https://github.com/ruby-processing/JRubyArt/issues', 'Github'

  source_control(url: 'https://github.com/ruby-processing/JRubyArt',
                 connection: 'scm:git:git://github.com/ruby-processing/JRubyArt.git',
                 developer_connection: 'scm:git:git@github.com/ruby-processing/JRubyArt.git')

  properties('processing.api' => 'http://processing.github.io/processing-javadocs/core/',
             'source.directory' => 'src',
             'polyglot.dump.pom' => 'pom.xml',
             'project.build.sourceEncoding' => 'UTF-8',
             'jogl.version' => '2.3.2',
             'jruby.api' => 'http://jruby.org/apidocs/')

  pom 'org.jruby:jruby:9.2.14.0'
  jar 'org.jogamp.jogl:jogl-all:${jogl.version}'
  jar 'org.jogamp.gluegen:gluegen-rt-main:${jogl.version}'
  jar 'org.processing:video:3.0.2'

  overrides do
    plugin :resources, '3.1.0'
    plugin :dependency, '3.1.2'
    plugin(:compiler, '3.8.1',
           'release' => '11')
    plugin(:javadoc, '2.10.4',
           'detectOfflineLinks' => 'false',
           'links' => ['${processing.api}',
                       '${jruby.api}'])
    plugin(:jar, '3.2.0',
           'archive' => {
             'manifestEntries' => {
               'Class-Path' => 'gluegen-rt.jar jog-all.jar'
             }
           })
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
