![elastic_labs](https://i.imgur.com/BsQNMcw.png)

> **Note:** Throughout this project, all root and user *password: 'password'*

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
- **Run initial setup - hosts, repos, user, ansible configurations**
  
  ```bash
  ./initial-setup.sh
  ```
  <details close>
  <summary> <h4>Script explanation</h4> </summary>
  This script does the following <br><br>
    
    - Configure /etc/hosts file for nodes
    - Setup ftp server on control node as repository
    - Add repo to nodes
    - Ensure python is installed on nodes
    - 
    - Use rhel-system-roles-timesync to synchronize all nodes 
  </details>
  
**Note:** Throughout this project, all root and user *password: 'password'*

   
### Installation
- **Install and configure elasticsearch and kibana**
  ```bash
  ./install.sh
  ```
- **Retrieve elastic password**
  ```bash
  cat password_result
  ```
- **Access Kibana with browser**
  ```bash
  http://localhost:5601
  ```
- **Log in with user `elastic` with password from `password_result`**
- **Add fleet server through UI**

- **Enroll RHEL Agents**
  ```bash
  ansible-playbook enroll_agents.yaml -vv
  ```
- **Run Windows integration playbook**
  ```bash
  ansible-playbook windows_integration.yaml -vv
  ```
- **Enroll Windows agent through Kibana UI**
