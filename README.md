![elastic_labs](https://i.imgur.com/BsQNMcw.png)

### Setup Environment
- **Insert the RHEL ISO on control node** <br><br>
- **Run the command to mount the ISO** <br><br>
  ```bash
  sudo mount /dev/sr0 /mnt
  ```
- **Add and configure the repository from the ISO** <br><br>
  ```bash
  dnf config-manager --add-repo=file:///mnt/AppStream
  dnf config-manager --add-repo=file:///mnt/BaseOS
  echo "gpgcheck=0" >> /etc/yum.repos.d/mnt_AppStream.repo
  echo "gpgcheck=0" >> /etc/yum.repos.d/mnt_BaseOS.repo
  ```
- **Install `git` and `ansible-core`** <br><br>
  ```bash
  dnf install -y git ansible-core
  ```
- **Clone the repository** <br><br>
  ```bash
  git clone https://github.com/Thuynh808/elastic_labs
  cd elastic_labs
  ```
- **Configure inventory `hosts`** <br><br>
  ```bash
  vim inventory
  ```
- **Run initial setup - hosts, repos, user, ansible configurations** <br><br>
  ```bash
  ./initial-setup.sh
  ```
   
### Installation
- **Install and configure elasticsearch and kibana** <br><br>
  ```bash
  ./install.sh
  ```
- **Retrieve elastic password** <br><br>
  ```bash
  cat password_result
  ```
- **Access Kibana with browser** <br><br>
  ```bash
  http://localhost:5601
  ```
- **Log in with user `elastic` with password from `password_result`** <br><br>
- **Add fleet server through UI** <br><br>

- **Enroll RHEL Agents**
  ```bash
  ansible-playbook enroll_agents.yaml -vv
  ```
- **Run Windows integration playbook** <br><br>
  ```bash
  ansible-playbook windows_integration.yaml -vv
  ```
- **Enroll Windows agent through Kibana UI**
