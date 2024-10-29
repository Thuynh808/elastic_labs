### Setup Environment
- **Insert the RHEL ISO on control node** <br><br>
- **Run the command to mount the ISO:** <br><br>
  ```bash
  sudo mount /dev/sr0 /mnt
  ```
- **Add and configure the repository from the ISO:** <br><br>
  ```bash
  dnf config-manager --add-repo=file:///mnt/AppStream
  dnf config-manager --add-repo=file:///mnt/BaseOS
  echo "gpgcheck=0" >> /etc/yum.repos.d/mnt_AppStream.repo
  echo "gpgcheck=0" >> /etc/yum.repos.d/mnt_BaseOS.repo
  ```
- **Install `git` and `ansible-core`:** <br><br>
  ```bash
  dnf install -y git ansible-core
  ```
### Installation
To install and set up the project, follow these steps:

1. **Clone the repository:** <br><br>
   ```bash
   git clone -b dev https://github.com/Thuynh808/elastic_labs
   cd elastic_labs
   ```
4. **Configure inventory `ansible_host`:** <br><br>
   ```bash
   vim inventory
   ```
5. **run initial setup - hosts, repos, user, ansible configs:** <br><br>
   ```bash
   ./initial-setup.sh
   ```
5. **install elasticsearch and kibana:** <br><br>
   ```bash
   ansible-playbook elastic_kibana_install.yaml -vv
   ```
7. **config elasticsearch and kibana:** <br><br> 
   ```bash
   ansible-playbook elastic_kibana_config.yaml -vv
   ```
5. **install and setup zeek on nodes:** <br><br>
   ```bash
   ansible-playbook zeek.yaml -vv
   ```
6. **cat out elastic password** <br><br>
   ```bash
   cat password_result
   ```
7. **navigate with browser to:** <br><br>
   ```bash
   http://localhost:5601
   ```
8. **log in with user `elastic` password from `password_result`** <br><br>

8. **run sysmon integration playbook** <br><br>
   ```bash
   ansible-playbook sysmon_integration.yaml -vv
   ```
9. **Add fleet server through ui** <br><br>

5. **run enroll playbook**
   ```bash
   ansible-playbook enroll_agents.yaml -vv
   ```


    
