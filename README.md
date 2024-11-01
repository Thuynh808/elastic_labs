![elastic_labs](https://i.imgur.com/BsQNMcw.png)

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
   git clone https://github.com/Thuynh808/elastic_labs
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
   ./install.sh
   ```
6. **print elastic password** <br><br>
   ```bash
   cat password_result
   ```
7. **navigate with browser to:** <br><br>
   ```bash
   http://localhost:5601
   ```
8. **log in with user `elastic` password from `password_result`** <br><br>

9. **Add fleet server through ui** <br><br>

5. **run enroll playbook**
   ```bash
   ansible-playbook enroll_agents.yaml -vv
   ```
<<<<<<< HEAD
8. **enroll windows agent through kibana ui**
=======
8. **run windows integration playbook** <br><br>
   ```bash
   ansible-playbook windows_integration.yaml -vv
   ```
8. **enroll windows agent through kibana ui"
>>>>>>> dev

    
