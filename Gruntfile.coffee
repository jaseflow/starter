module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    jade:
      compile:
        files:
          'public/index.html': ['views/index.jade']

    watch:
      jade:
        files: ['views/*.jade']
        tasks: ['jade']
      livereload:
        options:
          livereload: true
        files: [
          'public/index.html'
        ]
  
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask 'default', ['jade']