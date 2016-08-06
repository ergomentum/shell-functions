# Ergomentum Shell Functions
Provides frequently used functions in shell scripts.

## Usage
Donwload shell functions:
```bash
curl -O https://github.com/ergomentum/shell-functions/blob/master/common_functions.sh
```

Include shell functions:
```bash
# shellcheck disable=SC1091
source common_functions.sh
```

### Traps (multi trap)
`traps` allow to build a stack of commands, run when the script exits. The command last registered via `traps` will be
run first. If you want a [Maven](http://maven.apache.org/) style execution summary with success or failure message,
register the `exit_trap` as first trap.

```bash
# Prints a Maven style execution summary (must be registered first)
traps exit_trap EXIT

# Will be run before the execution summary:
traps "echo outer" EXIT

# Will be run first:
traps "echo inner" EXIT
```

## Contributing
To contribute a feature or a bugfix please open a [pull request](https://github.com/ergomentum/shell-function/pulls) on
[GitHub](https://github.com/ergomentum/shell-functions/).

See [CONTRIBUTING](https://github.com/ergomentum/shell-functions/blob/master/CONTRIBUTING.md) for details.

## License
See the [LICENSE](https://github.com/ergomentum/shell-functions/blob/master/LICENSE.md) file for license rights and
limitations (Apache License, Version 2.0).
