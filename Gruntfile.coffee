DEBUG = process.env.NODE_ENV is 'development'

module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    uglify:
      options:
        mangle: false
        banner: '/*! <%= pkg.name %> <%= grunt.template.today(\'yyyy-mm-dd HH:mm:ss\') %> */\n'
      lib:
        files:
          'public/js/lib.js': [
            'bower_components/jquery/jquery.js'
            'bower_components/underscore/underscore.js'
          ]
      prod:
        src: ['public/js/lib.js', 'public/js/app.js']
        dest: 'public/js/app.min.js'

    stylus:
      compile:
        options:
          compress: !DEBUG
        files:
          'public/css/app.css': 'lib/styles/app.styl'

    browserify:
      dist:
        files:
          'public/js/app.js': ['lib/**/*.coffee']
        options:
          transform: ['coffeeify']

    jade:
      compile:
        options:
          data:
            DEBUG: DEBUG
        files:
          'public/index.html': ['lib/views/index.jade']

    autoprefixer:
      options: {}     
      no_dest:
        src: "public/css/app.css"

    watch:
      stylus:
        files: ['lib/styles/*.styl']
        tasks: ['stylus']
      browserify:
        files: ['lib/**/*.coffee']
        tasks: ['browserify']
      jade:
        files: ['lib/*.jade', 'lib/templates/*.jade']
        tasks: ['jade']
      livereload:
        options:
          livereload: true
        files: [
          'public/css/app.css'
          'public/index.html'  # todo: having this forces full reload on style change :(
          'public/js/app.js'
        ]
  
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-browserify'  
  
  grunt.registerTask 'default', ['browserify', 'stylus', 'jade', 'autoprefixer', 'uglify']