project 'jruby_art', 'https://github.com/ruby-processing/JRubyArt' do

  model_version '4.0.0'
  id 'ruby-processing:jruby_art:2.6.1'
  packaging 'jar'

  description 'Jar for JRubyArt'

  {
    'monkstone' => 'Martin Prout', 'sampottinger' => 'Sam Pottinger',
    'benfry' => 'Ben Fry', 'REAS' => 'Casey Reas', 'codeanticode' => 'Andres Colubri'
  }.each do |key, value|
    developer key do
      name value
      roles 'developer'
    end
  end

  issue_management 'https://github.com/ruby-processing/JRubyArt/issues', 'Github'

  source_control( :url => 'https://github.com/ruby-processing/JRubyArt',
                  :connection => 'scm:git:git://github.com/ruby-processing/JRubyArt.git',
                  :developer_connection => 'scm:git:git@github.com/ruby-processing/JRubyArt.git' )

  properties( 'jruby_art.basedir' => '${project.basedir}',
              'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
              'source.directory' => 'src',
              'polyglot.dump.pom' => 'pom.xml',
              'project.build.sourceEncoding' => 'UTF-8',
              'jogl.version' => '2.3.2',
              'jruby.version' => '9.3.2.0',
              'itextpdf.version' => '5.5.13.2',
              'batik.version' => '1.14',
              'jruby.api' => 'http://jruby.org/apidocs/' )

  jar 'org.jruby:jruby-base:${jruby.version}'
  jar 'org.jogamp.jogl:jogl-all:${jogl.version}'
  jar 'org.jogamp.gluegen:gluegen-rt-main:${jogl.version}'
  jar 'org.processing:video:3.0.2'
  jar 'org.apache.xmlgraphics:batik-all:${batik.version}'
  jar 'com.itextpdf:itextpdf:${itextpdf.version}'

  overrides do
    plugin :resources, '3.1.0'
    plugin :dependency, '3.1.2' do
      execute_goals( :id => 'default-cli',
                     'artifactItems' => [ { 'groupId' =>  'com.itextpdf',
                                            'artifactId' =>  'itextpdf',
                                            'version' =>  '${itextpdf.version}',
                                            'type' =>  'jar',
                                            'outputDirectory' =>  '${jruby_art.basedir}/library/pdf' },
                                          { 'groupId' =>  'org.apache.xmlgraphics',
                                            'artifactId' =>  'batik-all',
                                            'version' =>  '${batik.version}',
                                            'type' =>  'jar',
                                            'outputDirectory' =>  '${jruby_art.basedir}/library/svg' } ] )
    end

    plugin( :compiler, '3.8.1',
            'release' =>  '11' )
    plugin( :javadoc, '2.10.4',
            'detectOfflineLinks' =>  'false',
            'links' => [ '${processing.api}',
                         '${jruby.api}' ] )
    plugin( :jar, '3.2.0',
            'archive' => {
              'manifestEntries' => {
                'Automatic-Module-Name' =>  'processing.core'
              }
            } )
    plugin :pmd, '3.14.0'
    plugin :jdeps, '3.1.2' do
      execute_goals 'jdkinternals', 'test-jdkinternals'
    end
  end

  build do
    resource do
      directory '${source.directory}/main/java'
      excludes '**/**/*.java'
    end
    resource do
      directory '${source.directory}/main/resources'
      includes '**/*.png', '**/*.txt', '**/*.glsl'
    end
  end

  reporting do
    plugin 'org.apache.maven.plugins:mavan-jxr-plugin:2.3'
  end

end
