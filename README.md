# GitHub CI/CD with Workflows and Actions

!["GitHub Actions"](.media/ghactions.png)

Presenting and demonstrating GitHub Actions and workflows.

## Agenda

- Git
  - Repository
  - Branches
  - Pull Request
- GitHub Workflows
- GitHub Actions
- GitHub Runners
  - Ubuntu, Windows
- Demo
  - Basic
  - Not so basic
  - Pull Request with what-if and automatic PR comment

Resources:

- [Quickstart](https://docs.github.com/en/actions/quickstart)
- [Starter workflows](https://github.blog/2021-12-17-getting-started-with-github-actions-just-got-easier/)
- [StackAbuse - Article](https://stackabuse.com/getting-started-with-github-actions-software-automation/)

## Git

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

Git is easy to learn and has a tiny footprint with lightning fast performance. It outclasses SCM tools like Subversion, CVS, Perforce, and ClearCase with features like cheap local branching, convenient staging areas, and multiple workflows.

- Central repository with all code.
- Branches for different directions/features or whatever your branching strategy decides.
- Everyone has a copy of the code.
- Commits and pushes to send code.
- Pull Request for reviews and automatic actions.

[More info](https://git-scm.com/)

## GitHub Actions/Workflows

You can configure a GitHub Actions workflow to be triggered when an event occurs in your repository, such as a pull request being opened or an issue being created.
Your workflow contains one or more jobs which can run in sequential order or in parallel.
Each job will run inside its own virtual machine runner, or inside a container, and has one or more steps that either run a script that you define or run an action, which is a reusable extension that can simplify your workflow.

A workflow is a configurable automated process that will run one or more jobs. Workflows are defined by a YAML file checked in to your repository and will run when triggered by an event in your repository, or they can be triggered manually, or at a defined schedule.

```yaml
name: Name of your workflow

on: # Trigger on
  workflow_dispatch: # Runs when manually triggered in portal
  pull_request: # Runs on Pull Requests
    paths: # Determines paths to run if changed
      - '.github/workflows/workflowfile.yml' # Will trigger if PR changes this file
      - 'src/bicep/**' # Will also trigger if PR changes files in this folder
      - '!**/*/README.md' # Exlucde files with exclamation mark
  push: # Runs on commits and pushes to named branches
    branches: # Name the branches which triggers this workflow
      - main # Will trigger on pushes to main
    paths:
      - '.github/workflows/workflowfile.yml' # Will trigger if push changes this file
      - 'src/bicep' # Will trigger if push changes any file in this folder
      - '!**/*/README.md' # Exlucde files with exclamation mark
  tags: # Trigger on tags pushed to repository
     - 'v*' # Will trigger if any tag has v* pattern
  schedule: # Will trigger on a cron schedule
    cron: '0 22 * * *' # This is a nighly build scheduled for 10PM every day.

env: # Declare environment variables
  myEnvironmentVariable: 'variable value' # This is a variable that can be used in your actions
  SUBSCRIPTION_ID: 'mySubscriptionIdFromASecret'

jobs: # Name different jobs. Different jobs run on different runners.
  build-and-deploy: # Name of your job
    runs-on: ubuntu-latest # Determine which OS to run on, most common ubuntu-latest or windows-latest. Can also run on a matrix of OS's.
    steps: # The steps are your actions

    - name: Checkout source code # Check out source code from your repo
      uses: actions/checkout@v2 # Names the GitHub Action which runs in this step

    - name: Run script # Name of this step
      run: | # Run inline script as declared below
        az login
        az account set -s '${{ secrets.SUBSCRIPTION_ID }}'

Job2: # Name of second job
    runs-on: {{matrix.os}} # Run several different OSs
      strategy:
        matrix: # Determines which runners to use
          os: [ubuntu-latest, windows-2016, macos-latest ]
      needs: build-and-deploy
      
      steps:
      - name: Checkout source code # Check out source code from your repo
        uses: actions/checkout@v2 # Names the GitHub Action which runs in this step
```

## Events

An event is a specific activity in a repository that triggers a workflow run. For example, activity can originate from GitHub when someone creates a pull request, opens an issue, or pushes a commit to a repository.

## Jobs

The jobs keyword lists actions that will be executed. One workflow can hold multiple jobs with multiple steps each.
By default, all jobs run in parallel, but we can make one job wait for the execution of another using the needs keyword.

## Actions

An action is a custom application for the GitHub Actions platform that performs a complex but frequently repeated task. Use an action to help reduce the amount of repetitive code that you write in your workflow files.

## Runners

A runner is a server that runs your workflows when they're triggered. Each runner can run a single job at a time. GitHub provides Ubuntu Linux, Microsoft Windows, and macOS runners to run your workflows; each workflow run executes in a fresh, newly-provisioned virtual machine.

### Hosted

GitHub hosted runners. Predefined OS and packages installed.

Available packages listed [here](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#preinstalled-software).

### Self-Hosted

You can self host a runner if you need custom tools installed.

## Demos

### Basic demo

[BasicWorkflow](.github/workflows/basicworkflow.yml)



### Simple demo

[SimpleWorkflow](.github/workflows/SimpleWorkflow.yml)

### Pull Request what-if

[DeploymentExample](.github/workflows/DeploymentExample.yml)
