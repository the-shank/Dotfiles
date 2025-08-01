#!/bin/bash

set -eu
set -o pipefail

! rm crate.01.normal &>/dev/null
! rm crate.02.identified &>/dev/null
! rm crate.03.expanded &>/dev/null
! rm crate.04.expanded.identified &>/dev/null
! rm crate.05.expanded.hygiene &>/dev/null
! rm crate.06.ast-tree &>/dev/null
! rm crate.07.ast-tree.expanded &>/dev/null
! rm crate.08.hir &>/dev/null
! rm crate.09.hir.identified &>/dev/null
! rm crate.10.hir.typed &>/dev/null
! rm crate.11.hir-tree &>/dev/null
! rm crate.12.thir-tree &>/dev/null
! rm crate.13.thir-flat &>/dev/null
! rm crate.14.mir &>/dev/null
# ! rm crate.15.stable-mir &>/dev/null
! rm crate.16.mir-cfg &>/dev/null

# Check that we are in a cargo project directory.
# We are using the existence of a Cargo.toml file as a marker for this.
check_cargo_toml() {
  if ! [[ -f "Cargo.toml" ]]; then
    echo "[!] Cargo.toml not found. Are you sure you are in a cargo package diretory?"
    exit 1
  fi
}

# Run a command (printing the command first).
run() {
  runcmd=$1
  echo ">> ${runcmd}"
  bash -c "${runcmd}"
}

target=""

# Function to check if "--lib" or "--tests" is present in the arguments
check_for_target() {
  local args=("$@")
  for i in "${!args[@]}"; do
    if [ "${args[i]}" == "--lib" ]; then
      echo "--lib argument found"
      target="--lib -- --test"
      return
    elif [ "${args[i]}" == "--test" ]; then
      local next_arg="${args[$((i + 1))]}"
      echo "Next argument after --test: ${next_arg}"
      target="--test ${next_arg} --"
      return
    fi
  done
  echo "--lib/--tests argument not found"
  return
}

# Call the function with all the script arguments
check_for_target "$@"

check_cargo_toml

run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=normal >crate.01.normal 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=identified >crate.02.identified 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=expanded >crate.03.expanded 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=expanded,identified >crate.04.expanded.identified 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=expanded,hygiene >crate.05.expanded.hygiene 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=ast-tree >crate.06.ast-tree 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=ast-tree,expanded >crate.07.ast-tree.expanded 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=hir >crate.08.hir 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=hir,identified >crate.09.hir.identified 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=hir,typed >crate.10.hir.typed 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=hir-tree >crate.11.hir-tree 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=thir-tree >crate.12.thir-tree 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=thir-flat >crate.13.thir-flat 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=mir -Z mir-opt-level=0 -Z mir-include-spans >crate.14.mir-built 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=mir-cfg -Z mir-opt-level=0 >crate.15.mir-built-cfg 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=mir -Z mir-include-spans >crate.16.mir 2>/dev/null"
run "cargo clean && cargo +nightly rustc ${target} -Z unpretty=mir-cfg >crate.17.mir-cfg 2>/dev/null"
# run "cargo clean && cargo rustc ${target} -- -Z unpretty=stable-mir >crate.16.stable-mir 2>/dev/null"
