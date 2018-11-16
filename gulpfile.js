const gulp = require( 'gulp' )
const sass = require( 'gulp-sass' )

gulp.task( 'style', () => {
    return gulp
        .src( [ './sass/*.sass', './sass/*.scss' ] )
        .pipe( sass().on( 'error', sass.logError ) )
        .pipe( gulp.dest( './static/stylesheets' ) )
} )

gulp.task( 'watch', () => {
    gulp.watch( './sass', [ 'style' ] )
} )

gulp.task( 'default', [ 'style', 'watch' ] )