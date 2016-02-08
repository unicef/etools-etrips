module.exports = function(grunt) {  
    grunt.initConfig({
        pkg : grunt.file.readJSON('package.json'),
        
        watch: {
            default: {                
                files: ['tests/*', '!Gruntfile.js', '!tests/conf_*.js'],
                tasks: ['clear', 'exec:default']
            
            }
        },

        exec: {
            default: {
                command: 'protractor ./tests/conf_dev.js'
            }
        }
    });

    grunt.loadNpmTasks('grunt-clear');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-exec');

    grunt.registerTask('default',['watch:default']);
};
