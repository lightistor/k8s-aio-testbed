# Pre-Requisites

# Pre-Requisites
[PH]

# Purpose
[PH]

# Inventory
- *playbooks*: Ansible Playbooks for x86 CentOS-compatible installation
- *setup-by-hand/gnu*: Contains the README.md for a by-hand installation of the All-in-One Test Bed for GNU Linux
- *setup-by-hand/ps*: Contains the README.md, artifacts and respective directory structure for setting it up in a Windows 10 with WSL-based environment

    - Incomplete due to port forwarding incompatibilities

# What is Done
- Orchestrate Platform setup with Ansible - [InProgress]
- Incorporate Docker Engine installation steps into the document and into execution steps

# What is to Come
- Path fixes for git-based project location
- Orchestrate compute onboarding on Cloud Service Provider Compute Pool with Terraform
- Generate VM cloud-image for `Preparation` steps-completed state conforming to cloud-init *best-practices*
- Spin-up multiple clusters to separate compute(Pulsar Runtime) and persistence services (Redis) workloads
- Manage end-to-end execution of the scenario:

    - Setup CI/CD environment and stage project 
    - Push initial commit
    - Push pipeline descriptor
    - Push revision and initiate pipeline setup
    - Revise pipeline setup script for hourly setup & teardown of platform for re-usability
    - Incorporate unit and integration tests into source-code
    - Add stages for platform sanity checks for the generated setup

- Optimizations:

    - Incorporate image caching into KinD cluster descriptor (See Verrazzano setup with KinD)
    - Incorporate private container image registry for infrastructure and platform setups
    - Automate pushing container images to be used within the orchestrated deployments to the KinD nodes

- Enhancements:
    
    - Incorporate multi-protocol configuration into MetalLB descriptor

- Nice-to-have:
    
    - Migrate out monitoring infrastructure components from compute runtime clusters to off-cluster setup
    - Incorporate overlay networking to setup multiple VM infrastructure for KinD
    - Consolidate off-cluster monitoring components into a dedicated KinD cluster