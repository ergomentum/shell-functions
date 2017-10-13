#!/bin/bash
#
# Exit immediately on errors:
set -e

# Handle undefined variables as error:
set -u

# Debugging:
#set -x

#
# Adds a statement to a stack which will be executed when the script exits.
# The exit status of the command run before trap will be saved in ${EXIT_STATUS}.
#
# @param ${1} The statement to be execute.
# @param ${2} One or multiple signals
# @return 0
#
traps() {
  [ ${#@} -lt 2 ] && printf >&2 "%s usage error\n" "${FUNCNAME}" && return 1
  local -r cmd=${1}; shift
  for i in "$@"; do
    local -r cmds=$(trap -p "${i}"|awk -F"'" '{print ";"$2}')
    # https://github.com/koalaman/shellcheck/wiki/SC2064#exceptions
    # shellcheck disable=SC2064
    trap "EXIT_STATUS=\$?;${cmd}${cmds#;EXIT_STATUS=\$?}" "${i}"
  done
}

exit_trap() {
  if [ "${EXIT_STATUS}" -ne 0 ]; then
    failure
  else
    success
  fi
  exit "${EXIT_STATUS}"
}

success() {
  printf "%s\nBUILD SUCCESS\n%s\n" "$(line)" "$(line)" >&2
}

failure() {
  printf "%s\nBUILD FAILURE\n%s\n" "$(line)" "$(line)" >&2
}

line() {
  for (( i=0; i < 80; i++ )); do echo -n '-'; done; echo
}
