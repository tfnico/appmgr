#!/usr/bin/env bats
# vim: set filetype=sh:

load utils

@test "./app instance list - all apps" {
  mkzip "app-a"
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.1 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-b -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-b -v 1.0
  [ $status -eq 0 ]

  app instance list; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Name                 Instance             Version             
app-a                env-a                1.1                 
app-a                env-b                1.0                 
app-b                env-a                1.0                 
app-b                env-b                1.0                 " ]

  app instance list -P name -P instance -P version; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "app-a:env-a:1.1
app-a:env-b:1.0
app-b:env-a:1.0
app-b:env-b:1.0" ]
}

@test "./app instance list - -n filter" {
  mkzip "app-a"
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.1 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-b -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-b -v 1.0
  [ $status -eq 0 ]

  app instance list -n foo; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Name                 Instance             Version             " ]

  app instance list -n app-a; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Name                 Instance             Version             
app-a                env-a                1.1                 
app-a                env-b                1.0                 " ]

  app instance list -n app-a -P name -P instance -P version; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "app-a:env-a:1.1
app-a:env-b:1.0" ]
}

@test "./app instance list - -i filter" {
  mkzip "app-a"
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.1 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-b -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-b -v 1.0
  [ $status -eq 0 ]

  app instance list -i foo; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Name                 Instance             Version             " ]

  app instance list -i env-a; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Name                 Instance             Version             
app-a                env-a                1.1                 
app-b                env-a                1.0                 " ]

  app instance list -i env-a -P name -P instance -P version; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "app-a:env-a:1.1
app-b:env-a:1.0" ]
}

@test "./app instance list - -n + -i filter" {
  mkzip "app-a"
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-a -v 1.1 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-a -i env-b -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-a -v 1.0 &&
  app instance install -r file -u $BATS_TEST_DIRNAME/data/app-a.zip -n app-b -i env-b -v 1.0
  [ $status -eq 0 ]

  app instance list -n foo -i bar; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Name                 Instance             Version             " ]

  app instance list -n app-a -i env-a; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "Name                 Instance             Version             
app-a                env-a                1.1                 " ]

  app instance list -n app-a -i env-a -P name -P instance -P version; echo_lines
  [ $status -eq 0 ]
  [ "$output" = "app-a:env-a:1.1" ]
}
