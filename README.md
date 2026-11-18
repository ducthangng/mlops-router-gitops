# mlops-router-gitops

Desired state for the AI gateway ([app repo](https://github.com/ducthangng/mlops-skeleton)). ArgoCD
syncs this repo; nothing is applied by hand.

```
charts/router/        Helm chart: router (gateway), redis (8.x, vector search), mock-llm
  values.yaml         shared defaults
  values-dev.yaml     image.tag bumped by Jenkins on every green build of main
  values-prod.yaml    image.tag changed only by promotion (`make promote` in the app repo)
argocd/gw-dev.yaml    Application -> ns router-dev  (auto-sync, prune, selfHeal)
argocd/gw-prod.yaml   Application -> ns router-prod (auto-sync, prune, selfHeal)
jenkins/values.yaml   Helm values for a FRESH Jenkins install only (the running one is never upgraded)
jenkins/casc/         JCasC, applied as a labelled ConfigMap (hot reload by the chart's sidecar)
jenkins/jobs/         job config.xml (router: multibranch, qualify: release qualification)
jenkins/qualify-cache-pvc.yaml   stage cache for the qualify job
```

- **Deploy to dev:** merge to main in the app repo. Jenkins pushes `router:<sha>` and commits the tag here.
- **Promote to prod:** `make promote` in the app repo (copies the dev tag into `values-prod.yaml` as a commit), review, push.
- **Rollback:** `git revert <commit>` here and push. ArgoCD converges.
- **Manual changes in the cluster are reverted** (selfHeal). Change them here instead.
