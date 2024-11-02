![elastic_labs](https://i.imgur.com/BsQNMcw.png)

## Project Overview
The elastic_labs project is designed to simulate a Elastic Stack environment using Ansible for automated deployment and management. This setup focuses on configuring a comprehensive SIEM system that includes Elasticsearch, Kibana, Zeek integration, and Elastic Agents on a controlled RHEL environment.

### Objectives
- Automate majority of the setup using Ansible, from system configuration to application deployment
- Integrate Elasticsearch and Kibana for data indexing and visualization
- Deploy Zeek on selected nodes to monitor network traffic and log activities
- Manage Elastic Agents on RHEL and Windows VMs for endpoint security and log collection
- Create and enforce policies through Fleet management in Kibana, enhancing the real-time security posture
- Create dashboards and rules for testing
- Generate log telemetry and trigger alerts for analysis

### Architecture
- **Control Node:** Hosts Elasticsearch and Kibana orchestrating the SIEM framework
- **Node1:** Setup as Fleet Server to manage agent policies in a centralized environment
- **Node1 and Node2:** Run Zeek for network monitoring and Elastic Agents for endpoint security
- **Node3-Windows:** Extends the monitoring to include Windows-specific threats using Sysmon and Windows Defender integrations

### Prerequisites
Before we begin, ensure the following are prepared:
- 3 RHEL 8 VMs
- 1 Windows 10 VM

| Server           | Role               | CPU | RAM  |
|------------------|--------------------|-----|------|
| Control(rhel 8)  | Management         | 4   | 8 GB |
| Node1(rhel 8)    | Fleet/Zeek         | 2   | 4 GB |     
| Node2(rhel 8)    | Elastic Agent/zeek | 2   | 2 GB |    
| Node3(windows 10)| Elastic Agent      | 4   | 8 GB |  

- **Network Configuration**: Set IP addresses and hostnames for each VM. Networking mode is set to NAT Network with port forwarding configured to allow access from host.

> **Note:** Throughout this project, root password set to *'password'*

## Setup Environment
- **Insert the RHEL ISO on control node**
  
- **Run the command to mount the ISO**
  
  ```bash
  sudo mount /dev/sr0 /mnt
  ```
- **Add and configure the repository from the ISO**
  
  ```bash
  dnf config-manager --add-repo=file:///mnt/AppStream
  dnf config-manager --add-repo=file:///mnt/BaseOS
  echo "gpgcheck=0" >> /etc/yum.repos.d/mnt_AppStream.repo
  echo "gpgcheck=0" >> /etc/yum.repos.d/mnt_BaseOS.repo
  ```
- **Install `git` and `ansible-core`**
  
  ```bash
  dnf install -y git ansible-core
  ```
- **Clone the repository**
  
  ```bash
  git clone https://github.com/Thuynh808/elastic_labs
  cd elastic_labs
  ```
- **Configure inventory `hosts`**
  
  ```bash
  vim inventory
  ```
- **Run initial setup**
  
  ```bash
  ./initial-setup.sh
  ```
  <details close>
  <summary> <h4>Script Breakdown</h4> </summary>
    
  - Install collections from requirements file
  - Generate root SSH keypair
  - Copy root public key to nodes
  - Configure /etc/hosts file for nodes
  - Setup ftp server on control node as repository
  - Add repo to nodes
  - Ensure python is installed on nodes
  - Use rhel-system-roles-timesync to synchronize all nodes 
  </details>
   
## Installation
- **Install and configure elasticsearch and kibana**
  ```bash
  ./install.sh
  ```
  <details close>
  <summary> <h4>Script Breakdown</h4> </summary>
    
  - Setup repositories for Elasticsearch and Kibana
  - Install Elasticsearch and Kibana
  - Open firewall ports for services
  - Set SELinux ports for services
  - Generate Elasticsearch token for Kibana
  - Enroll Kibana
  - Reset password for elastic user
  - Generate encryption keys for Kibana
  - Create Fleet server policy
  - Add Zeek integration policy
  - Add System logs/metrics integration policy
  - Adjust Kibana service file
  - Install Zeek on node1 and node2
  - Confirm services are up and running on necessary ports
  </details>
  
- **Retrieve elastic password**
  ```bash
  cat password_result
  ```
- **Access Kibana with browser**
  ```bash
  http://localhost:5601
  ```
  > **Note:** Make sure to setup port forwarding for NAT Network to allow host machine to access VMs

- **Log in with user `elastic` with password from `password_result`**

- **Add Fleet Server through Kibana UI**
  <details close>
  <summary> <h4>Expand guide</h4> </summary>
    
  - Navigate to Fleet and add Fleet Server <br><br>
  - Set Fleet Server host URL and generate service token <br><br>
  ![elastic_labs](https://i.imgur.com/ma5gQGk.png) <br><br>
  ![elastic_labs](https://i.imgur.com/jWWZ9tR.png) <br><br>
  - Copy provided command to install Fleet Server <br><br>
  ![elastic_labs](https://i.imgur.com/5A0a4lt.png) <br><br>
  - SSH into `node1` and execute the copied command <br><br>
  ![elastic_labs](https://i.imgur.com/jWWZ9tR.png) <br><br>
  ![elastic_labs](https://i.imgur.com/MNtyluj.png) <br><br>
  </details>
  
- **Enroll RHEL Agents defined in `inventory` file** <br>
  ```bash
  ansible-playbook enroll_agents.yaml -vv
  ```
- **Add `Sysmon` and `Windows Defender` integrations to Agent Policy** <br>
  ```bash
  ansible-playbook windows_integration.yaml -vv
  ```
- **Enroll Windows agent through Kibana UI**
  <details close>
  <summary> <h4>Expand Guide</h4> </summary>
    
  - Navigate to Fleet and add Agent <br><br>
  - Choose the Agent Policy and copy provided windows command to install and enroll Elastic Agent<br><br>
  > **Note:** Add `--insecure` to the command to trust self signed certificate
  
  ![elastic_labs](https://i.imgur.com/ZiXn1HF.png) <br><br>
  - Confirm Agent enrollment and incoming data <br><br>
  ![elastic_labs](https://i.imgur.com/rvHa3du.png) <br><br>
  </details>

  ---

<details close>
<summary> <h2>Operational Verification</h2> </summary>

**In this section, let's make sure our installation process was a success.** <br><br>
- **Confirm `/etc/hosts` on nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/c1qDwOP.png) <br><br>
- **Synchronized time across all nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/VuT455D.png) <br><br>
- **Elasticsearch and Kibana are running with no errors** <br><br>
  ![elastic_labs](https://i.imgur.com/R989tOf.png) <br><br>
- **Confirm `zeek` is running on node1 and node2** <br><br>
  ![elastic_labs](https://i.imgur.com/XxkUmrh.png) <br><br>
- **Through Kibana, verify agents are present** <br><br>
  ![elastic_labs](https://i.imgur.com/4QBdwlx.png) <br><br>
- **Verify Agent Policies** <br><br>
  ![elastic_labs](https://i.imgur.com/2TiUS90.png) <br><br>
- **Verify Integrations** <br><br>
  ![elastic_labs](https://i.imgur.com/CusSugk.png) <br><br>
  ![elastic_labs](https://i.imgur.com/pmdsl4F.png) <br><br>
- **Check health and integrations on individual nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/d1MmB9J.png) <br><br>
  ![elastic_labs](https://i.imgur.com/AyL61bM.png) <br><br>
  ![elastic_labs](https://i.imgur.com/4VkiFN2.png) <br><br>
- **Verify logs are coming in from our integrations** <br><br>
  ![elastic_labs](https://i.imgur.com/yWOb8G2.png) <br><br>
  ![elastic_labs](https://i.imgur.com/3sodjob.png) <br><br>
  ![elastic_labs](https://i.imgur.com/kI9bWMd.png) <br><br>
  </details>

  <details close>
<summary> <h2>Rules and Alerts</h2> </summary>

- **Confirm `/etc/hosts` on nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/c1qDwOP.png) <br><br>
- **Synchronized time across all nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/VuT455D.png) <br><br>
- **Elasticsearch and Kibana are running with no errors** <br><br>
  ![elastic_labs](https://i.imgur.com/R989tOf.png) <br><br>
- **Confirm `zeek` is running on node1 and node2** <br><br>
  ![elastic_labs](https://i.imgur.com/XxkUmrh.png) <br><br>
- **Through Kibana, verify agents are present** <br><br>
  ![elastic_labs](https://i.imgur.com/4QBdwlx.png) <br><br>
- **Verify Agent Policies** <br><br>
  ![elastic_labs](https://i.imgur.com/2TiUS90.png) <br><br>
- **Verify Integrations** <br><br>
  ![elastic_labs](https://i.imgur.com/CusSugk.png) <br><br>
  ![elastic_labs](https://i.imgur.com/pmdsl4F.png) <br><br>
- **Check health and integrations on individual nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/d1MmB9J.png) <br><br>
  ![elastic_labs](https://i.imgur.com/AyL61bM.png) <br><br>
  ![elastic_labs](https://i.imgur.com/4VkiFN2.png) <br><br>
- **Verify logs are coming in from our integrations** <br><br>
  ![elastic_labs](https://i.imgur.com/yWOb8G2.png) <br><br>
  ![elastic_labs](https://i.imgur.com/3sodjob.png) <br><br>
  ![elastic_labs](https://i.imgur.com/kI9bWMd.png) <br><br>
  </details>

  <details close>
<summary> <h2>Testing and Analysis</h2> </summary>

- **Confirm `/etc/hosts` on nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/c1qDwOP.png) <br><br>
- **Synchronized time across all nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/VuT455D.png) <br><br>
- **Elasticsearch and Kibana are running with no errors** <br><br>
  ![elastic_labs](https://i.imgur.com/R989tOf.png) <br><br>
- **Confirm `zeek` is running on node1 and node2** <br><br>
  ![elastic_labs](https://i.imgur.com/XxkUmrh.png) <br><br>
- **Through Kibana, verify agents are present** <br><br>
  ![elastic_labs](https://i.imgur.com/4QBdwlx.png) <br><br>
- **Verify Agent Policies** <br><br>
  ![elastic_labs](https://i.imgur.com/2TiUS90.png) <br><br>
- **Verify Integrations** <br><br>
  ![elastic_labs](https://i.imgur.com/CusSugk.png) <br><br>
  ![elastic_labs](https://i.imgur.com/pmdsl4F.png) <br><br>
- **Check health and integrations on individual nodes** <br><br>
  ![elastic_labs](https://i.imgur.com/d1MmB9J.png) <br><br>
  ![elastic_labs](https://i.imgur.com/AyL61bM.png) <br><br>
  ![elastic_labs](https://i.imgur.com/4VkiFN2.png) <br><br>
- **Verify logs are coming in from our integrations** <br><br>
  ![elastic_labs](https://i.imgur.com/yWOb8G2.png) <br><br>
  ![elastic_labs](https://i.imgur.com/3sodjob.png) <br><br>
  ![elastic_labs](https://i.imgur.com/kI9bWMd.png) <br><br>
  </details>

  ## Conclusion

  This project was super fun and engaging! From diving into documentations to troubleshooting errors,  

