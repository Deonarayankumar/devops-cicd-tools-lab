# DevOps CI/CD Tools Lab

Hands-on lab for Jenkins, Azure DevOps, JFrog Artifactory, and SonarQube integration with a minimal Python Flask service.

## Prerequisites

- Python 3.11+
- Jenkins 2.4+ with Pipeline and shared library configured
- Azure DevOps project with pipeline permissions
- JFrog Artifactory (or CLI pointed at a sandbox repo)
- SonarQube server and scanner

## Quick start

```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r app/requirements.txt
flask --app app.app run --debug
curl http://localhost:5000/health
```

## Project layout

| Path | Purpose |
|------|---------|
| `app/` | Minimal Flask API |
| `jenkins/` | Declarative pipeline and shared library |
| `.azuredevops/` | Azure Pipelines YAML |
| `scripts/` | JFrog upload and verification helpers |
| `docs/` | Architecture and rollback runbooks |

## Jenkins

1. Create a multibranch or pipeline job pointing at `jenkins/Jenkinsfile`.
2. Configure shared library `devops-cicd-tools-lab` with root `jenkins/shared-library`.
3. Set credentials: `jfrog-api-key`, `sonar-token`.

## Azure DevOps

Import `.azuredevops/azure-pipelines.yml` and configure variable groups:

- `JFROG_URL`, `JFROG_REPO` (no secrets in Git)
- Service connection for SonarQube

## JFrog scripts

```bash
export JFROG_URL=https://artifactory.example.com
export JFROG_REPO=devops-lab
export JFROG_API_KEY=<from-vault>
./scripts/jfrog-upload.sh dist/app-1.0.0.tar.gz
./scripts/jfrog-check-artifacts.sh app-1.0.0
```

## Learnings

- Declarative Jenkins pipelines with shared library reuse
- Multi-stage Azure DevOps YAML with quality gates
- Artifact promotion patterns with JFrog
- SonarQube static analysis in CI

Author: **Deonarayan** — Cloud DevOps Engineer
