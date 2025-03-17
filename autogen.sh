#!/bin/sh

# The real source files are:
#
# acinclude.m4 (used by aclocal)
# configure.ac (main autoconf file)
# Makefile.am, */Makefile.am (automake config files)
#
# All the rest is auto-generated.

# Function to create the m4 directory if it doesn't exist
create_m4_directory() {
    if [ ! -d m4 ]; then
        mkdir m4
    fi
}

# Function to handle errors and exit
bail_out() {
    echo
    echo "  Something went wrong, bailing out!"
    echo
    exit 1
}

# Function to run a command and handle errors
run_command() {
    local cmd="$1"
    echo "Running $cmd"
    eval "$cmd" || bail_out
}

main() {
    # Create m4 directory if it doesn't exist
    create_m4_directory

    # Step 1: Generate aclocal.m4
    run_command "aclocal"

    # Step 2: Run libtoolize
    run_command "libtoolize -f -c || glibtoolize -f -c"
    run_command "libtoolize --automake || glibtoolize --automake"

    # Step 3: Generate Makefile.in
    run_command "automake --add-missing --copy"

    # Step 4: Generate configure
    run_command "autoconf"

    echo
    echo "All done."
    echo "To build the software now, do something like:"
    echo
    echo "$ ./configure [...other options]"
    echo "$ make"
}

# Execute the main function
main