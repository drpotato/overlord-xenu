module.exports = function (grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        coffee: {
            main: {
                files: {
                    'build/game.js': ['src/*.coffee']
                }
            }
        },

        watch: {
            coffee: {
                files: ['src/*.coffee'],
                tasks: ['coffee:main'],
                options: {
                    livereload: true,
                    atBegin: true
                }
            }
        }
    });

    // Load in tasks
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-coffee');

    // Set up default tasks
    grunt.registerTask('default', ['watch']);
};
