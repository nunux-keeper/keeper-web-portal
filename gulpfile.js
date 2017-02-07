var gulp        = require('gulp'),
    deploy      = require('gulp-gh-pages');

gulp.task('deploy', function () {
  return gulp.src('./public/**/*').pipe(deploy({branch: 'master'}));
});

