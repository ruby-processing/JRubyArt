require 'jruby_art/version'
version = JRubyArt::VERSION
project 'rp5extras', 'https://github.com/ruby-processing/JRuby' do

  model_version '4.0.0'
  inception_year '2015'
  id 'ruby-processing:rp5extras', version
  inherit 'org.sonatype.oss:oss-parent:7'
  packaging 'jar'

  description 'rp5extras for JRubyArt'

  developer 'monkstone' do
    name 'Martin Prout'
    email 'martin_p@lineone.net'
    roles 'developer' 
  end

  issue_management 'https://github.com/ruby-processing/JRubyArt/issues', 'Github'

  source_control( :url => 'https://github.com/ruby-processing/JRubyArt',
                  :connection => 'scm:git:git://github.com/ruby-processing/JRubyArt.git',
                  :developer_connection => 'scm:git:git@github.com/ruby-processing/JRubyArt.git' )

  properties( 'maven.compiler.source' => '1.8',
              'project.build.sourceEncoding' => 'UTF-8',
              'maven.compiler.target' => '1.8' )

  pom 'org.jruby:jruby:9.0.4.0'
  jar 'org.processing:core:3.0.1'
  jar 'org.processing:video:3.0.1'

  plugin( :compiler, '3.1',
          'source' =>  '1.8',
          'target' =>  '1.8' )
  plugin( :jar, '2.4',
          'archive' => {
            'manifestFile' =>  'MANIFEST.MF'
          } )

  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'rpextras'
  end
end
