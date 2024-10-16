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
- **Create `ansible` user on `control node` and set password:** <br><br>
  ```bash
  sudo useradd -m -s /bin/bash ansible
  echo "ansible:password" | sudo chpasswd
  echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
  su - ansible
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
   ansible-playbook elastic_kibana.yaml -vv
   ```
6. **cat out enrollemnt_token:** <br><br>
   ```bash
   cat enrollment_token password_result
   ```
7. navigate with browser to control's ip on port 5601
8. copy and paste enrollment token  
9. **run verification_code executable:** <br><br>
   ```bash
   ./verification_code.sh
   ```
10. copy and paste verification code
11. log in with user `elastic` password from password_result

    
