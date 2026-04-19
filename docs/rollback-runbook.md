# Rollback Runbook

## When to use

- Pipeline publishes a broken artifact
- Health checks fail after deployment
- SonarQube quality gate regression on promoted build

## Jenkins rollback

1. Identify last known-good build number in Jenkins history.
2. Re-run the **Publish to JFrog** stage from that build, or manually upload:
   ```bash
   ./scripts/jfrog-upload.sh dist/devops-cicd-tools-lab-<GOOD_BUILD>.tar.gz
   ```
3. Verify artifact presence:
   ```bash
   ./scripts/jfrog-check-artifacts.sh devops-cicd-tools-lab-<GOOD_BUILD>.tar.gz
   ```

## Azure DevOps rollback

1. Open **Pipelines → Runs** and locate the last green run on `main`.
2. Click **Rerun failed jobs** or redeploy the published artifact from **Artifacts**.
3. Confirm test results published for the selected run.

## Post-rollback validation

```bash
curl -f http://<host>/health
curl -f http://<host>/api/info
```

## Communication template

> Rollback executed for devops-cicd-tools-lab. Restored build `<BUILD_ID>`. Root cause investigation tracked in incident ticket.

## Prevention

- Enforce SonarQube quality gate before publish
- Keep last 20 builds (Jenkins `logRotator`)
- Tag releases in Git after successful production deploy
