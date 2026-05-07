# Static Analysis Toolkit

Open-source static analysers installed by the devenv VM
(`provision/install-security-tools.sh`). One main tool per vulnerability
class; specialist tools added where a generic scanner is weak.

| # | Class | Tool(s) | Why |
|---|---|---|---|
| 1 | Injection (SQL / Command / Code / XSS) | **semgrep** | Polyglot rules for taint into `exec`, query builders, template renderers |
| 2 | Injection (XXE) | **semgrep** | XXE-specific rules across JVM, .NET, Python, JS XML parsers |
| 2 | Injection (ReDoS) | **regexploit** | Doyensec; finds catastrophic backtracking in regex literals |
| 3 | Path & Network (Path traversal, SSRF, Open redirect) | **semgrep** | Tracks `Path.join`, `requests.get`, redirect helpers |
| 4 | Auth & Access (AuthN bypass, IDOR, CSRF, Race) | **semgrep** + **gosec** | Best-effort: missing auth decorators, unsafe `goroutine` access, CSRF token absence |
| 5 | Memory Safety (overflow, UAF, unsafe) | **cppcheck**, **clang-tidy**, **flawfinder** | C/C++ specialists; cppcheck for general bugs, clang-tidy `clang-analyzer-*` checks for UAF/leaks, flawfinder for `strcpy`-class smells |
| 6 | Cryptography (timing, alg confusion, weak primitives) | **semgrep** + **bandit** + **gosec** | MD5/SHA1/DES/ECB, JWT `alg=none`, `crypto.compare` misuse |
| 7 | Deserialization | **semgrep** + **bandit** | `pickle.load`, `yaml.load`, `ObjectInputStream`, `json-yaml-load` |
| 8 | Protocol & Encoding (cache safety, encoding confusion, length-prefix trust) | **semgrep** | Host-header trust, `Content-Length` vs body, charset/encoding patterns |

Adjacent (not directly asked but useful):
- **trufflehog** — high-precision secret scanning (regex + entropy + verifiers)
- **trivy** — SCA + IaC misconfigurations + container CVEs

## Quick-reference invocations

For an AI agent or quick CLI run. All commands assume you're in the root of
the codebase being analysed.

### Injection / path / SSRF / crypto / deser / proto (semgrep)

```sh
# Broad rule sweep, JSON output
semgrep scan \
  --config p/security-audit \
  --config p/owasp-top-ten \
  --config p/cwe-top-25 \
  --json --metrics off \
  > semgrep.json

# Tighter, language-specific
semgrep scan --config p/python --json > semgrep-python.json
semgrep scan --config p/javascript --config p/typescript --json > semgrep-js.json
semgrep scan --config p/golang --json > semgrep-go.json
semgrep scan --config p/java --json > semgrep-java.json
```

### ReDoS (regexploit)

```sh
# Walk a directory, report catastrophic regexes per file
regexploit-py path/to/python/code     # Python source
regexploit-js path/to/js/code         # JS/TS source
regexploit-json file.json             # Raw regex strings
```

### Python-only crypto / deser / shell-injection (bandit)

```sh
bandit -r path/ -f json -o bandit.json
```

### Go-only crypto / SSRF / unsafe / hardcoded creds (gosec)

```sh
gosec -fmt json -out gosec.json ./...
```

### C / C++ memory safety

```sh
# cppcheck — lots of bug classes, low false-positive
cppcheck --enable=all --inconclusive --xml --xml-version=2 \
  src/ 2> cppcheck.xml

# clang-tidy — needs compile_commands.json (cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON)
clang-tidy -checks='clang-analyzer-*,bugprone-*,cert-*' \
  -p build/ src/**/*.{c,cpp,h,hpp}

# flawfinder — quick smell pass for C/C++ unsafe APIs
flawfinder --html --context src/ > flawfinder.html
```

### Secrets / SCA / IaC

```sh
trufflehog filesystem . --json --no-update > trufflehog.json
trivy fs --format json --output trivy.json .
```

## Notes for AI agent use

- All tools above produce JSON or XML so findings can be ingested
  programmatically.
- Semgrep runs offline once rule packs are cached (the install script
  pre-fetches `p/security-audit`, `p/owasp-top-ten`, `p/cwe-top-25`).
- For C/C++, clang-tidy produces the richest results but needs a
  `compile_commands.json`. Without one, fall back to cppcheck/flawfinder.
- gosec needs a working Go module (`go.mod` present).
- regexploit only inspects regex literals — wire it into the pipeline
  alongside semgrep, not as a replacement.
- Static analysis can detect *patterns of risk*; it cannot prove logic-flaw
  classes (auth bypass, IDOR, race conditions) without supplementary
  fuzzing or dynamic testing.
