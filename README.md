# Deploy automated kubernetes cluster with ArgoCD using GitOps, GitHub actions

## Run
  - [Purpose](#purpose)
  - [Prerequsites](#prerequsites)
  - [Repository](#repository)
  - [Github secrets](#github-secrets)
  - [Install Argocd](#install-argocd)
    - [Login in to Argo CD UI](#login-in-to-argo-cd-ui-user-interface) 
    - [ArgoCD application manifest file](#argocd-application-manifest-file)
  - [Docker token](#docker-playground)
  - [Clean up](#clean-up)

## Purpose

Create a fully automated cd pipeline using argocd in kubernetes.

![design](design/design.png)
## Prerequsites

- [argocd](https://argo-cd.readthedocs.io/en/stable/getting_started/).
- [GitHub Actions](https://docs.docker.com/build/ci/github-actions/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/) or [minikube](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/).
- [docker](https://www.docker.com/), [docker push](https://docs.docker.com/engine/reference/commandline/push/).

## Repository 

1. Create a github repository (app-configuration-code) and clone the repo (means empty repo).
2. After cloning, create folder `dev-env`. Add your configuration manifest file ([deployment.yaml](k8s-deploy/deployment.yaml)).
3. Create a github repository (app-source-code) and clone the repo (means empty repo). Add your application code ([web-app.html](web-app.html))

  - Note: This code acts as source code for your (web) application.

4. Later, push the code to repository :octocat: .

### Github secrets

#### DockerHub Token

1. Sign in to **Docker Hub**.

2. Select your **username** in the top-right corner and from the drop-down menu select **Account Settings**.

3. Click the **Security** tab and then **New Access Token**. copy token.

4. In GitHub, Goto → select: repo → setting → click: Secrets and variables → click: New repository secret (Name: *DOCKERHUB_TOKEN* and Secret: copy step 3 token).

#### DockerHub username
1. In GitHub, Goto → select: repo → setting → click: Secrets and variables → click: New repository secret (Name: *DOCKERHUB_USERNAME* and Secret: <dockerhub_username>).

#### GitHub userID

1. In GitHub, Goto → select: repo → setting → click: Secrets and variables → click: New repository secret (Name: *GIT_USERID* and Secret: <github_username>).

#### GitHub user email
1. In GitHub, Goto → select: repo → setting → click: Secrets and variables → click: New repository secret (Name: *GIT_USER_EMAIL* and Secret: <github_email>).


#### GitHub passwd (Fine-grained personal access tokens)

1. In GitHub, Select your username in the top-right corner and from the drop-down menu select **Settings**.

2. On left pane → click: Developer setting → personal access tokens → Fine-grained tokens → Generate new token → give details: token name, expire, select repo, generate token. Copy token (used in step 3).

3. In GitHub, Goto → select: repo → setting → click: Secrets and variables → click: New repository secret (Name: *GIT_PASS* and Secret: <copy token from step 3>).

## Install Argocd

To install argocd agent with stable version, execute the following command in your cluster.

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
or

- kubectl create -f [install.yaml](install.yaml)

### Login in to Argo CD UI (user interface)

One of the ways: 
- Port forwarding

`kubectl port-forward svc/argocd-server -n argocd 8080:443`

In browser enter the → http://127.0.0.1:8080

user name: *`admin`* 

password::white_check_mark:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o yaml
# after getting the passwd, decode it!
echo -n "ODkxc3dmSHdyeUZxxxxx==" | base64 --decode
```

### ArgoCD application manifest file:

Execute the below code in cluster for [application](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/) spec for argocd.

> **Note**: Update the parameters:
- repoURL (giturl) and 
- path (github folder)
- server: (cluster endpoint)
- namespace

```bash
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: myapp-argo-application
  namespace: argocd
  labels:
    name: myapp-argo-application
  finalizers:
    # The default behaviour is foreground cascading deletion. It delete both the app and it's resource.
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default # default namespace. i.e, your deployment created in default namespace
  source:
    repoURL: https://github.com/sree7k7/k8s #github repo url
    targetRevision: HEAD
    path: <folder> #e.g dev-env #git folder, where the code lies.
  destination:
    server: https://kubernetes.default.svc
    namespace: default
# if you don't have namespace, use create Namespace=true syncpolicy config
  syncPolicy:
    syncOptions:
    - CreateNamespace=true
    # changes made to cluster to sync github, argoCD will see the changes made in manifest file
    automated:
      selfHeal: true
      prune: true # trim. if the resources should be pruned during auto-syncing.
```

Create the changes with kubectl:

- kubectl create -f [application.yaml](application-argocd/application.yaml)

Any updates and changes:
`kubectl replace -f application.yaml --force`



## Clean up

- In terminal execute the following command:

```docker
kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
After, in terminal execute, `kubectl get all -n argocd`
- expected result: No resources found in argocd namespace.