# Architecture

## Overview

This lab demonstrates an end-to-end CI/CD pipeline for a minimal Python Flask service using Jenkins, Azure DevOps, SonarQube, and JFrog Artifactory.

```
Developer → Git Push → CI (Jenkins / Azure DevOps)
                          ├── Unit Tests (pytest)
                          ├── SonarQube Analysis
                          ├── Package (tar.gz)
                          └── Publish → JFrog Artifactory
```

## Components

| Component | Role |
|-----------|------|
| Flask app | Sample service with `/health` and `/api/info` |
| Jenkins | Primary pipeline with shared library |
| Azure DevOps | Alternative YAML pipeline for Azure-centric teams |
| SonarQube | Code quality and security scanning |
| JFrog | Binary artifact storage and promotion |

## Pipeline stages

1. **Checkout** — clone repository
2. **Build & Test** — virtualenv, pip install, pytest
3. **SonarQube** — static analysis gate
4. **Package** — create versioned tarball
5. **Publish** — upload to JFrog via API

## Design decisions

- Shared library (`buildPython.groovy`) isolates Python build logic for reuse
- No secrets in Git; credentials via Jenkins/Azure variable groups
- Artifact naming: `{app-name}-{build-number}.tar.gz`

Author: Deonarayan — Cloud DevOps Engineer
