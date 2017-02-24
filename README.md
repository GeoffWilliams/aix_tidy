[![Build Status](https://travis-ci.org/GeoffWilliams/aix_tidy.svg?branch=master)](https://travis-ci.org/GeoffWilliams/aix_tidy)
# aix_tidy

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Apply miscellaneous "tidying up" settings to AIX (6.1/7.1)

## Setup

### What aix_tidy affects

The module necessarily touches many parts of the system in order to perform the required changes.  Consult the module source code in order to understand what is going on under the hood.

Since `aix_tidy` locks down critical security settings, its vital that user's understand how and why it works to prevent lockout or misconfiguration scenarios.

## Usage

Most classes will need to be loaded using the `class` resource syntax in order to pass the appropriate class defaults, eg:

```puppet
class { "foo:bar":
  param1 => "value1",
  param2 => "value2",
}
```

Parameters, where available, are documented inside the individual classes.  See [Reference section](#reference).

## Reference
Reference documentation is generated directly from source code using [puppet-strings](https://github.com/puppetlabs/puppet-strings).  You may regenerate the documentation by running:

```shell
bundle exec puppet strings
```

Or you may view the current [generated documentation](https://rawgit.com/GeoffWilliams/aix_tidy/master/doc/index.html).

The documentation is no substitute for reading and understanding the module source code, and all users should ensure they are familiar and comfortable with the operations this module performs before using it.

## Limitations
* AIX 6.1/7.1 only
* Not supported by Puppet, Inc.

## Development

PRs accepted :)

## Testing
This module supports testing using [PDQTest](https://github.com/GeoffWilliams/pdqtest).


Test can be executed with:

```
bundle install
bundle exec pdqtest all
```

See `.travis.yml` for a working CI example
