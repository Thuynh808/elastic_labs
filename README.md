![elastic_labs](https://i.imgur.com/BsQNMcw.png)

> **Note:** Throughout this project, root password set to *'password'*

### Setup Environment
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
   
### Installation
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
