AC_PREREQ([2.71])
# Initialize the package
AC_INIT([jbig2enc],
        [m4_esyscmd_s([test -d .git && git describe --abbrev=4 2>/dev/null || cat VERSION])],
        [agl@imperialviolet.org],
        [jbig2enc],
        [https://github.com/agl/jbig2enc])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign -Wall -Werror no-dependencies])

# Check for supported tools
AC_PROG_CXX
AM_PROG_AR
AC_LANG([C++])
CXXFLAGS="$CXXFLAGS -std=c++17"

AC_DEFINE_UNQUOTED([PACKAGE_NAME], ["${PACKAGE_NAME}"], [Name of package])
AC_DEFINE_UNQUOTED([PACKAGE_VERSION], ["${PACKAGE_VERSION}"], [Version number])
AC_SUBST([PACKAGE_NAME])
AC_SUBST([PACKAGE_VERSION])


GENERIC_MAJOR_VERSION=$(echo "$VERSION" | $SED 's/\([[^.]][[^.]]*\).*/\1/')
GENERIC_MINOR_VERSION=$(echo "$VERSION" | $SED 's/[[^.]][[^.]]*.\([[^.]][[^.]]*\).*/\1/')
GENERIC_MICRO_VERSION=`echo "$VERSION" | $SED 's/[[^.]][[^.]]*.[[^.]][[^.]]*.\(.*\)/\1/'`

# Define version strings
GENERIC_VERSION="$GENERICS_MAJOR_VERSION.$GENERICS_MINOR_VERSION.$GENERICS_MICRO_VERSION"
GENERIC_RELEASE="$GENERICS_MAJOR_VERSION.$GENERICS_MINOR_VERSION"
AC_SUBST(GENERIC_VERSION)
AC_SUBST(GENERIC_RELEASE)

LT_INIT

# Conditional for MinGW
AM_CONDITIONAL(MINGW, false)

# Platform specific setup
AC_CANONICAL_HOST
case "${host_os}" in
    mingw*)
        AC_DEFINE_UNQUOTED([MINGW], 1, [This is a MinGW system])
        AC_CHECK_LIB(ws2_32, [_head_libws2_32_a])
        ;;
esac

# Handle rpath option
AC_ARG_ENABLE([rpath],
    AS_HELP_STRING([--enable-rpath], [Enable rpath for libraries (NOT RECOMMENDED)]),
    [], [enable_rpath=no])

AM_CONDITIONAL([ENABLE_RPATH], [test "x$enable_rpath" = "xyes"])

# Check for dependencies
PKG_CHECK_MODULES([LEPTONICA], [lept >= 1.74], [have_lept=true], [have_lept=false])
if ! $have_lept; then
    AC_MSG_ERROR([Leptonica 1.74 or higher is required. Try to install libleptonica-dev package.])
fi

# Check for math library
AC_CHECK_LIB([m], [sqrt], [], [
    AC_MSG_ERROR([Error! libm not detected.])
])

# Generate Makefiles
AC_CONFIG_FILES([
    Makefile
    src/Makefile
    doc/Makefile
])
AC_OUTPUT

# Show configuration summary
AC_MSG_NOTICE([
Configuration summary:
  Version:          $VERSION
  Host system:      $host
  Install prefix:   $prefix
  Compiler:         $CXX
  CXXFLAGS:         $CXXFLAGS
  LDFLAGS:          $LDFLAGS
  LEPTONICA_LIBS:   $LEPTONICA_LIBS
  Enable rpath:     $enable_rpath
])

# Final message
echo ""
echo "Configuration is done."
echo "You can now build and install $PACKAGE_NAME by running:"
echo ""
echo "$ make"
echo "$ sudo make install"
echo "$ sudo ldconfig"
echo ""