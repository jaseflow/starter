module.exports = function(grunt) {
    
    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        stylus: {
            compile: {
                files: {
                    'public/css/app.css': 'source/styles/app.styl'
                }
            }
        },

        connect: {
            server: {
                options: {
                    port: 8000,
                    useAvailablePort: true,
                    base: 'public',
                    hostname: '*',
                    livereload: true
                }
            }
        },

        autoprefixer: {
            options: {},
            no_dest: {
                src: 'public/css/app.css'
            }
        },

        watch: {
           stylus: {
               files: ['source/styles/app.styl'],
               tasks: ['stylus']
           },
           livereload: {
               options: {
                   livereload: true
               },
               files: [
                   'public/css/app.css',
                   'public/index.html'
               ]
           }
        }

    });


    // Load tasks
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-contrib-stylus'); 
    grunt.loadNpmTasks('grunt-autoprefixer');
    grunt.loadNpmTasks('grunt-contrib-watch');

    // Register tasks
    grunt.registerTask('default', ['stylus','autoprefixer']);
    grunt.registerTask('server', ['connect','watch']);
}
