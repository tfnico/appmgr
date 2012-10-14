#!/usr/bin/env bats
# vim: set filetype=sh:

load utils

# TODO: Add test for installing duplicate version

@test "./app app install app-a" {
  mkzip "app-a"
  app app install \
    -r file \
    -u $BATS_TEST_DIRNAME/data/app-a.zip \
    -n app-a -i prod

  echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Creating instance 'prod' for 'app-a'
Unpacking...
Running postinstall...
Hello World!
Postinstall completed successfully
Changing current symlink" ]
  [ ${#lines[*]} == 6 ]
}

@test "./app app install install-test-env" {
  mkzip "install-test-env"
  app app install \
    -r file \
    -u $BATS_TEST_DIRNAME/data/install-test-env.zip \
    -n install-test-env -i prod -v 1.0

  echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Creating instance 'prod' for 'install-test-env'
Unpacking...
Running postinstall...
PATH=/bin:/usr/bin
PWD=$WORK/install-test-env/prod/versions/1.0
SHLVL=1
_=/usr/bin/env
Postinstall completed successfully
Changing current symlink" ]
  [ ${#lines[*]} == 9 ]
}
