// Generated on 2013-11-09 using generator-backbone-amd 0.0.4
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/**/*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {
  // show elapsed time at the end
  require('time-grunt')(grunt);
  // load all grunt tasks
  require('load-grunt-tasks')(grunt);


  grunt.file.read(".env").split("\n").forEach(function (line){

    var matches;
    if (matches = line.match(/^(.+)=\"?([^\"]+)\"?$/m)) {

      var key = matches[1], value = matches[2];

      if (process.env[key] == null)
        process.env[key] = value;

    }
  });

  grunt.initConfig({
    // configurable paths
    yeoman: {
      app: 'app',
      dist: 'dist'
    },
    watch: {
      coffee: {
        files: ['<%= yeoman.app %>/scripts/**/*.coffee'],
        tasks: ['coffee:dist']
      },
      coffeeTest: {
        files: ['test/spec/**/*.coffee'],
        tasks: ['coffee:test']
      },
      less: {
        files: ['<%= yeoman.app %>/styles/**/*.less'],
        tasks: ['less']
      },
      styles: {
        files: ['<%= yeoman.app %>/styles/**/*.css'],
        tasks: ['copy:styles', 'autoprefixer']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '<%= yeoman.app %>/*.html',
          '.tmp/styles/**/*.css',
          '{.tmp,<%= yeoman.app %>}/scripts/**/*.js',
          '<%= yeoman.app %>/images/**/*.{png,jpg,jpeg,gif,webp,svg}'
        ]
      },
      jst: {
        files: [
          '<%= yeoman.app %>/scripts/templates/*.ejs'
        ],
        tasks: ['jst']
      },
      aggregate_scripts: {
        files: [
          '.tmp/scripts/models/**/*',
          '.tmp/scripts/views/**/*'
        ],
        tasks: ['aggregate_scripts']
      }
    },
    connect: {
      options: {
        port: 9000,
        livereload: 35739,
        // change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      },
      livereload: {
        options: {
          //open: true,
          base: [
            '.tmp',
            '<%= yeoman.app %>'
          ]
        }
      },
      test: {
        options: {
          base: [
            '.tmp',
            'test',
            '<%= yeoman.app %>'
          ]
        }
      },
      dist: {
        options: {
          open: true,
          base: '<%= yeoman.dist %>',
          livereload: false
        }
      }
    },
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= yeoman.dist %>/*',
            '!<%= yeoman.dist %>/.git*'
          ]
        }]
      },
      server: '.tmp'
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      all: [
        'Gruntfile.js',
        '<%= yeoman.app %>/scripts/**/*.js',
        '!<%= yeoman.app %>/scripts/vendor/*',
        'test/spec/**/*.js'
      ]
    },
    coffeelint: {
      all: [
        '<%= yeoman.app %>/scripts/**/*.coffee',
        '!<%= yeoman.app %>/scripts/vendor/*',
        'test/spec/**/*.coffee'
      ]
    },
    mocha: {
      all: {
        options: {
          run: true,
          urls: ['http://<%= connect.test.options.hostname %>:<%= connect.test.options.port %>/index.html']
        }
      }
    },
    coffee: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/scripts',
          src: '**/*.coffee',
          dest: '.tmp/scripts',
          ext: '.js'
        }]
      },
      test: {
        files: [{
          expand: true,
          cwd: 'test/spec',
          src: '**/*.coffee',
          dest: '.tmp/spec',
          ext: '.js'
        }]
      }
    },
    less: {
      options: {
        paths: [
          '<%= yeoman.app %>/bower_components',
          '<%= yeoman.app %>/styles'
        ],
        //dumpLineNumbers: true
      },
      dist: {
        files: [{
          expand: true,            // Enable dynamic expansion.
          cwd: '<%= yeoman.app %>/styles/', // Src matches are relative to this path.
          src: ['**/*.less'],        // Actual pattern(s) to match.
          dest: '.tmp/styles/',        // Destination path prefix.
          ext: '.css',            // Dest filepaths will have this extension.
        }],
      },
      server: {
        files: [{
          expand: true,            // Enable dynamic expansion.
          cwd: '<%= yeoman.app %>/styles/', // Src matches are relative to this path.
          src: ['**/*.less'],        // Actual pattern(s) to match.
          dest: '.tmp/styles/',        // Destination path prefix.
          ext: '.css',            // Dest filepaths will have this extension.
        }],
      }
    },
    autoprefixer: {
      options: {
        browsers: ['last 1 version']
      },
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '**/*.css',
          dest: '.tmp/styles/'
        }]
      }
    },
    requirejs: {
      dist: {
        // Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
        options: {
          // `name` and `out` is set by grunt-usemin
          baseUrl: '<%= yeoman.app %>/../.tmp/scripts',
          optimize: 'none',
          paths: {
            'bower' : 'test'
            //'templates': '../../.tmp/scripts/templates'
          },
          // TODO: Figure out how to make sourcemaps work with grunt-usemin
          // https://github.com/yeoman/grunt-usemin/issues/30
          //generateSourceMaps: true,
          // required to support SourceMaps
          // http://requirejs.org/docs/errors.html#sourcemapcomments
          preserveLicenseComments: false,
          useStrict: true,
          wrap: true
          //uglify2: {} // https://github.com/mishoo/UglifyJS2
        }
      }
    },
    'bower-install': {
      app: {
        html: '<%= yeoman.app %>/index.html',
        ignorePath: '<%= yeoman.app %>/'
      }
    },
    rev: {
      dist: {
        files: {
          src: [
            '<%= yeoman.dist %>/scripts/**/*.js',
            '<%= yeoman.dist %>/styles/**/*.css',
            '<%= yeoman.dist %>/images/**/*.{png,jpg,jpeg,gif,webp}',
            '<%= yeoman.dist %>/styles/fonts/**/*.*'
          ]
        }
      }
    },
    useminPrepare: {
      options: {
        dest: '<%= yeoman.dist %>'
      },
      html: '<%= yeoman.app %>/index.html'
    },
    usemin: {
      options: {
        assetsDirs: ['<%= yeoman.dist %>']
      },
      html: ['<%= yeoman.dist %>/**/*.html'],
      css: ['<%= yeoman.dist %>/styles/**/*.css']
    },
    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '**/*.{png,jpg,jpeg}',
          dest: '<%= yeoman.dist %>/images'
        }]
      }
    },
    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '**/*.svg',
          dest: '<%= yeoman.dist %>/images'
        }]
      }
    },
    cssmin: {
      // This task is pre-configured if you do not wish to use Usemin
      // blocks for your CSS. By default, the Usemin block from your
      // `index.html` will take care of minification, e.g.
      //
      //   <!-- build:css({.tmp,app}) styles/main.css -->
      //
      // dist: {
      //   files: {
      //     '<%= yeoman.dist %>/styles/main.css': [
      //       '.tmp/styles/**/*.css',
      //       '<%= yeoman.app %>/styles/**/*.css'
      //     ]
      //   }
      // }
    },
    htmlmin: {
      dist: {
        options: {
          /*removeCommentsFromCDATA: true,
          // https://github.com/yeoman/grunt-usemin/issues/44
          //collapseWhitespace: true,
          collapseBooleanAttributes: true,
          removeAttributeQuotes: true,
          removeRedundantAttributes: true,
          useShortDoctype: true,
          removeEmptyAttributes: true,
          removeOptionalTags: true*/
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>',
          src: '*.html',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    // Put files not handled in other tasks here
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>',
          dest: '<%= yeoman.dist %>',
          src: [
            '*.{ico,png,txt}',
            '.htaccess',
            'images/**/*.{webp,gif}',
            'styles/fonts/**/*.*',
            'bower_components/bootstrap/fonts/*.*'
          ]
        }]
      },
      styles: {
        expand: true,
        dot: true,
        cwd: '<%= yeoman.app %>/styles',
        dest: '.tmp/styles/',
        src: '**/*.css'
      }
    },
    bower: {
      all: {
        rjsConfig: '<%= yeoman.app %>/scripts/main.js'
      }
    },
    jst: {
      options: {
        amd: true,
        processName: function(filename) {
          return filename
            .replace(grunt.config("yeoman.app") + "/scripts/templates/", "")
            .replace(/\.[a-z0-9]+$/i, "");
        }
      },
      compile: {
        files: {
          '.tmp/scripts/templates.js': ['<%= yeoman.app %>/scripts/templates/*.ejs']
        }
      }
    },
    concurrent: {
      server: [
        'less',
        'coffee:dist',
        'jst',
        'copy:styles'
      ],
      test: [
        'coffee',
        'jst',
        'copy:styles'
      ],
      dist: [
        'coffee',
        'less',
        'jst',
        'copy:styles',
        'imagemin',
        'svgmin',
        'htmlmin'
      ]
    }, 
    aggregate_scripts: {
      views: {
        files : [{
          dest: '.tmp/scripts/views.js',
          src: 'views/**/*.js',
          cwd: '.tmp/scripts'
        }]
      },
      models: {
        files : [{
          dest: '.tmp/scripts/models.js',
          src: 'models/**/*.js',
          cwd: '.tmp/scripts'
        }]
      }
    },
    's3-sync': {
      options: {
        key: process.env.AWS_ACCESS_KEY_ID,
        secret: process.env.AWS_SECRET_ACCESS_KEY,
        bucket: "problemkind.io",
        region: "us-west-2",
        access: "public-read",
        concurrency: 5
      }, 
      deploy: {
        files: [{
          root: "dist",
          src: "dist/**/*.*",
          nocase: true,
          dest: "/"
        }]
      }
    }
  });


  grunt.registerMultiTask('aggregate_scripts', function () {

    var relativeFilename = function (file, fileSrc) {
      return fileSrc
        .replace(file.cwd, '')
        .replace(/\.js$/, '');
    }
    var className = function (file, fileSrc) {
      return relativeFilename(file, fileSrc)
        .replace(/^.*\//, '')
        .replace(/^[a-z]/g, function (a) { return a.toUpperCase(); })
        .replace(/_[a-z]/g, function (a) { return a[1].toUpperCase(); });
    }
  
    this.files.forEach(function (file) {

      var output = 
        'define([' + 
        file.src.map(function (fileSrc) { return '"./' + relativeFilename(file, fileSrc) + '"'; }).join(', ') + 
        '], function (' + 
        file.src.map(function (fileSrc) { return className(file, fileSrc); }).join(',') + 
        ') { return {' + 
        file.src.map(function (fileSrc) { return className(file, fileSrc) + ':' + className(file, fileSrc); }).join(', ') + 
        '}; })';

      grunt.file.write(file.dest, output);

    });
  });

  grunt.registerTask('server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'concurrent:server',
      'aggregate_scripts',
      'autoprefixer',
      'connect:livereload',
      'watch'
    ]);
  });

  grunt.registerTask('test', [
    'clean:server',
    'concurrent:test',
    'aggregate_scripts',
    'autoprefixer',
    'connect:test',
    'mocha'
  ]);

  grunt.registerTask('build', [
    'clean:dist',
    'useminPrepare',
    'concurrent:dist',
    'aggregate_scripts',
    'requirejs',
    'autoprefixer',
    'concat',
    'cssmin',
    'uglify',
    'copy:dist',
    'rev',
    'usemin'
  ]);

  grunt.registerTask('default', [
    'jshint',
    'test',
    'build'
  ]);

  grunt.registerTask('deploy', [
    'build',
    's3-sync:deploy'
  ]);
};
