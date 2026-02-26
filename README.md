# Lintel GitHub Action

Validate JSON, YAML, and TOML files against [JSON Schema](https://json-schema.org/) in your pull requests.

Creates a **Lintel** Check Run with inline annotations on the files changed in your PR.

## Quick Start

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
      - uses: lintel-rs/action@v0
```

With zero configuration Lintel auto-discovers files and matches them against schemas from the [SchemaStore](https://www.schemastore.org/) catalog.

## Inputs

| Input          | Description                                           | Required | Default               |
| -------------- | ----------------------------------------------------- | -------- | --------------------- |
| `version`      | `lintel` version to install                           | No       | `latest`              |
| `github-token` | GitHub token for creating Check Runs                  | No       | `${{ github.token }}` |
| `paths`        | Paths or globs to validate                            | No       | _(auto-discover)_     |
| `exclude`      | Comma-separated exclude patterns                      | No       |                       |
| `no-catalog`   | Disable SchemaStore catalog matching                  | No       | `false`               |
| `args`         | Additional arguments passed to `lintel github-action` | No       |                       |

### `version`

Pin a specific release version instead of using the latest.

```yaml
- uses: lintel-rs/action@v0
  with:
    version: v0.1.0
```

### `github-token`

Token used to create the Check Run. The default `github.token` is sufficient -- no PAT required.

### `paths`

Space-separated paths or globs to validate. When omitted, Lintel auto-discovers JSON, YAML, and TOML files in the repository.

```yaml
- uses: lintel-rs/action@v0
  with:
    paths: "config/**/*.yaml src/*.json"
```

### `exclude`

Comma-separated patterns to exclude from validation.

```yaml
- uses: lintel-rs/action@v0
  with:
    exclude: "vendor/**, node_modules/**"
```

### `no-catalog`

Disable automatic schema matching from the [SchemaStore](https://www.schemastore.org/) catalog. Useful when you only want to validate files that have explicit schema mappings in `lintel.toml`.

```yaml
- uses: lintel-rs/action@v0
  with:
    no-catalog: true
```

### `args`

Pass additional arguments directly to `lintel github-action`.

```yaml
- uses: lintel-rs/action@v0
  with:
    args: "--verbose"
```

## How It Works

1. Downloads the `lintel` binary from [lintel-rs/lintel](https://github.com/lintel-rs/lintel) releases
2. Runs `lintel github-action` on your repository files
3. Creates a GitHub Check Run named **Lintel** with:
   - Inline annotations on files with schema violations
   - A summary of all findings
   - Pass/fail conclusion

## Permissions

The action needs `checks: write` permission to create Check Runs and `contents: read` to access repository files.

```yaml
permissions:
  checks: write
  contents: read
```

## Configuration

Place a `lintel.toml` in your repository root to configure schema mappings, exclude patterns, and more. See the [Lintel documentation](https://github.com/lintel-rs/lintel) for details.
