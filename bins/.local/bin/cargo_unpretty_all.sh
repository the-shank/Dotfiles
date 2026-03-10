#!/bin/bash

# set -x
set -eu
set -o pipefail

# Clean old outputs
rm -f crate.*

# Check that we are in a cargo project directory.
check_cargo_toml() {
  if ! [[ -f "Cargo.toml" ]]; then
    echo "[!] Cargo.toml not found. Are you sure you are in a cargo package directory?"
    exit 1
  fi
}

target=""

# Function to check for target arguments (--lib, --tests, or --test <name>)
check_for_target() {
  local args=("$@")
  for i in "${!args[@]}"; do
    if [ "${args[i]}" == "--lib" ]; then
      echo "--lib argument found"
      target="--lib --"
      return
    elif [ "${args[i]}" == "--tests" ]; then
      echo "--tests argument found"
      target="--tests --"
      return
    elif [ "${args[i]}" == "--test" ]; then
      local next_arg="${args[$((i + 1))]}"
      echo "Next argument after --test: ${next_arg}"
      target="--test ${next_arg} --"
      return
    fi
  done
  echo "[!] --lib/--tests/--test <name> argument not found, at least one needs to be provided"
  exit 1
}

check_for_target "$@"
check_cargo_toml

# Commands definition: index | suffix | flags
commands=$(
  cat <<EOF
01|normal|-Z unpretty=normal
02|identified|-Z unpretty=identified
03|expanded|-Z unpretty=expanded
04|expanded.identified|-Z unpretty=expanded,identified
05|expanded.hygiene|-Z unpretty=expanded,hygiene
06|ast-tree|-Z unpretty=ast-tree
07|ast-tree.expanded|-Z unpretty=ast-tree,expanded
08|hir|-Z unpretty=hir
09|hir.identified|-Z unpretty=hir,identified
10|hir.typed|-Z unpretty=hir,typed
11|hir-tree|-Z unpretty=hir-tree
12|thir-tree|-Z unpretty=thir-tree
13|thir-flat|-Z unpretty=thir-flat
14|mir-built|-Z unpretty=mir -Z mir-opt-level=0 -Z mir-include-spans
15|mir-built-cfg|-Z unpretty=mir-cfg -Z mir-opt-level=0
16|mir|-Z unpretty=mir -Z mir-include-spans
17|mir-cfg|-Z unpretty=mir-cfg
EOF
)

# Function to run a single unpretty command
run_unpretty() {
  local idx=$1
  local suffix=$2
  local flags=$3
  local target_dir="target/unpretty_${idx}"
  local err_log="target/unpretty_${idx}.err"

  echo ">> [${idx}] Generating crate.${idx}.${suffix}..."
  mkdir -p "${target_dir}"

  # Run cargo with nice, capturing stderr. If it fails, print the error log and return the exit code.
  if ! CARGO_TARGET_DIR="${target_dir}" nice cargo +nightly rustc ${target} ${flags} >"crate.${idx}.${suffix}" 2>"${err_log}"; then
    echo "[!] [${idx}] Build failed for crate.${idx}.${suffix}" >&2
    cat "${err_log}" >&2
    return 1
  fi
  rm -f "${err_log}"
}
export -f run_unpretty
export target

# Trap to clean up temporary target directories and error logs on exit
cleanup() {
  echo ">> Cleaning up temporary artifacts..."
  rm -rf target/unpretty_*
  rm -f target/unpretty_*.err
}
trap cleanup EXIT

# Run commands in parallel.
# --halt now,fail=1: Exit immediately if any job fails.
echo "${commands}" | parallel --colsep '\|' --halt now,fail=1 run_unpretty {1} {2} {3}

echo ">> All outputs generated successfully."
#!/bin/bas -- -Z unpretty=stable-mir >crate.16.stable-mir 2>/dev/null"
