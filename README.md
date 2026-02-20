# Lintel GitHub Action

Validate JSON, YAML, and TOML files against JSON Schema in your pull requests.

Creates a **Lintel** Check Run with inline annotations on the files changed in your PR.

## Usage

```yaml
name: Lint
on: [pull_request]

permissions:
  checks: write
  contents: read

jobs:
  lintel:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: lintel-rs/action@v1
```

## Inputs

| Input          | Description                                           | Default               |
| -------------- | ----------------------------------------------------- | --------------------- |
| `version`      | `lintel-github-action` version to install             | `latest`              |
| `github-token` | GitHub token for creating Check Runs                  | `${{ github.token }}` |
| `paths`        | Paths or globs to validate                            | _(auto-discover)_     |
| `exclude`      | Comma-separated exclude patterns                      |                       |
| `no-catalog`   | Disable SchemaStore catalog matching                  | `false`               |
| `args`         | Additional arguments passed to `lintel-github-action` |                       |

## How it works

1. Downloads the `lintel-github-action` binary from this repo's releases
2. Runs validation on your repository files
3. Creates a GitHub Check Run named **Lintel** with:
   - Inline annotations on files with errors
   - A summary table of all findings
   - Pass/fail conclusion

## Permissions

The action needs `checks: write` permission to create Check Runs. The default
`github.token` is sufficient -- no PAT required.

## Configuration

Place a `lintel.toml` in your repository root to configure schema mappings,
exclude patterns, and more. See the [Lintel documentation](https://github.com/lintel-rs/lintel)
for details.
