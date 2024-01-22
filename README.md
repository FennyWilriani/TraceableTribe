## 1. TraceableTribe (Configure Processes and Communications)

### Skills Practiced

- Configure activity traceability and flow of work
- Configure collaboration and communication

### Project Description

In this project, you'll integrate Azure Boards, GitHub Actions, and Azure Pipelines to manage the flow of work items from creation to completion. You'll also implement custom dashboards for actionable insights, document the project with wikis and diagrams, and automate notifications and release documentation.

### Diagram description

A flowchart illustrating the integration of Azure Boards, GitHub Actions, and Azure Pipelines. The chart will show how work items move from 'To Do' to 'Done' and how code changes trigger pipeline actions and update the board.

### Programming required?: ✅

### Azure Services Used

- Azure Boards
- Azure Pipelines
- GitHub Actions
- Azure Monitor

### Steps

1.  Initial Setup:

    -   Create a new project in Azure DevOps.
    -   Initialize a new repository on GitHub.
2.  Azure Boards Configuration:

    -   Enable Azure Boards and create a backlog.
    -   Create different work item types like User Stories, Bugs, and Tasks.
3.  Repository Integration:

    -   Integrate the GitHub repository with Azure Boards.
4.  Workflow Automation:

    -   Create a GitHub Actions workflow that triggers on pull request events.
    -   Integrate this workflow to update work item status in Azure Boards.
5.  Azure Pipelines Configuration:

    -   Set up a build and release pipeline in Azure Pipelines.
    -   Connect this pipeline to your GitHub repository.
    -   Implement traceability by linking pipeline runs to work items.
6.  Metrics and Dashboards:

    -   Use Azure Boards to create a custom dashboard.
    -   Include widgets for cycle time, lead time, and other flow metrics.
7.  Documentation and Diagrams:

    -   Create a Wiki in Azure DevOps to document the project.
    -   Use a tool like draw.io to create process diagrams and embed them in the Wiki.
8.  Release Documentation:

    -   Configure the Azure Pipeline to generate release notes and API documentation automatically.
    -   Integrate this documentation into your project Wiki.
9.  Notification Automation:

    -   Set up webhook notifications to inform team members about key events, such as work item updates or pipeline failures.
10. Review and Test:

    -   Review the entire setup for traceability and communication.
    -   Perform a dry-run to validate that everything is working as expected.
