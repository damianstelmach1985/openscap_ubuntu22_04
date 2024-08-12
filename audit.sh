#!/bin/bash

# Definiowanie ścieżki docelowej
DEST_DIR="/etc/audit/rules.d"

# Sprawdzanie, czy katalog docelowy istnieje
if [ ! -d "$DEST_DIR" ]; then
    echo "Katalog $DEST_DIR nie istnieje. Tworzenie katalogu."
    mkdir -p "$DEST_DIR"
fi

# Tworzenie i zapisywanie plików .rules z odpowiednimi regułami

# MAC-policy.rules
cat <<EOL > "$DEST_DIR/MAC-policy.rules"
-w /etc/selinux/ -p wa -k MAC-policy
EOL

# access.rules
cat <<EOL > "$DEST_DIR/access.rules"
-a always,exit -F arch=b32 -S creat -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S creat -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S creat -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S creat -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S open -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S open -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S open -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S open -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S openat -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S openat -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S openat -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S openat -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S truncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b32 -S truncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S truncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
-a always,exit -F arch=b64 -S truncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
EOL

# action.rules
cat <<EOL > "$DEST_DIR/action.rules"
-w /etc/sudoers -p wa -k actions
-w /etc/sudoers.d/ -p wa -k actions
EOL

# audit_rules_networkconfig_modification.rules
cat <<EOL > "$DEST_DIR/audit_rules_networkconfig_modification.rules"
-a always,exit -F arch=b32 -S sethostname,setdomainname -F key=audit_rules_networkconfig_modification
-a always,exit -F arch=b64 -S sethostname,setdomainname -F key=audit_rules_networkconfig_modification
-w /etc/issue -p wa -k audit_rules_networkconfig_modification
-w /etc/issue.net -p wa -k audit_rules_networkconfig_modification
-w /etc/hosts -p wa -k audit_rules_networkconfig_modification
-w /etc/networks -p wa -k audit_rules_networkconfig_modification
-w /etc/network/ -p wa -k audit_rules_networkconfig_modification
EOL

# audit_rules_usergroup_modification.rules
cat <<EOL > "$DEST_DIR/audit_rules_usergroup_modification.rules"
-w /etc/group -p wa -k audit_rules_usergroup_modification
-w /etc/gshadow -p wa -k audit_rules_usergroup_modification
-w /etc/security/opasswd -p wa -k audit_rules_usergroup_modification
-w /etc/passwd -p wa -k audit_rules_usergroup_modification
-w /etc/shadow -p wa -k audit_rules_usergroup_modification
EOL

# audit_time_rules.rules
cat <<EOL > "$DEST_DIR/audit_time_rules.rules"
-a always,exit -F arch=b32 -S adjtimex -F key=audit_time_rules
-a always,exit -F arch=b64 -S adjtimex -F key=audit_time_rules
-a always,exit -F arch=b32 -S settimeofday -F key=audit_time_rules
-a always,exit -F arch=b64 -S settimeofday -F key=audit_time_rules
-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=audit_time_rules
-a always,exit -F arch=b32 -S stime -F key=audit_time_rules
-w /etc/localtime -p wa -k audit_time_rules
EOL

# delete.rules
cat <<EOL > "$DEST_DIR/delete.rules"
-a always,exit -F arch=b32 -S rename -F auid>=1000 -F auid!=unset -F key=delete
-a always,exit -F arch=b64 -S rename -F auid>=1000 -F auid!=unset -F key=delete
-a always,exit -F arch=b32 -S renameat -F auid>=1000 -F auid!=unset -F key=delete
-a always,exit -F arch=b64 -S renameat -F auid>=1000 -F auid!=unset -F key=delete
-a always,exit -F arch=b32 -S unlink -F auid>=1000 -F auid!=unset -F key=delete
-a always,exit -F arch=b64 -S unlink -F auid>=1000 -F auid!=unset -F key=delete
-a always,exit -F arch=b32 -S unlinkat -F auid>=1000 -F auid!=unset -F key=delete
-a always,exit -F arch=b64 -S unlinkat -F auid>=1000 -F auid!=unset -F key=delete
EOL

# immutable.rules - włączenie tej opcji uniemożliwi resetowanie reguł
cat <<EOL > "$DEST_DIR/immutable.rules"
-e 2
EOL

# export.rules
cat <<EOL > "$DEST_DIR/export.rules"
-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -F key=export
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -F key=export
EOL

# logins.rules
cat <<EOL > "$DEST_DIR/logins.rules"
-w /var/run/faillock -p wa -k logins
-w /var/log/lastlog -p wa -k logins
EOL

# maintenance.rules
cat <<EOL > "$DEST_DIR/maintenance.rules"
-w /var/log/sudo.log -p wa -k maintenance
EOL

# modules.rules
cat <<EOL > "$DEST_DIR/modules.rules"
-a always,exit -F arch=b32 -S delete_module -F auid>=1000 -F auid!=unset -F key=modules
-a always,exit -F arch=b64 -S delete_module -F auid>=1000 -F auid!=unset -F key=modules
-a always,exit -F arch=b32 -S init_module -F auid>=1000 -F auid!=unset -F key=modules
-a always,exit -F arch=b64 -S init_module -F auid>=1000 -F auid!=unset -F key=modules
-w /sbin/insmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-w /sbin/rmmod -p x -k modules
EOL

# perm_mod.rules
cat <<EOL > "$DEST_DIR/perm_mod.rules"
-a always,exit -F arch=b32 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S fremovexattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S fremovexattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b32 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S fchown -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S fchown -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S fsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S fsetxattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S fsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S fsetxattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b32 -S lchown -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S lchown -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S lremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S lremovexattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S lremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S lremovexattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b32 -S lsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S lsetxattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S lsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b32 -S removexattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S removexattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S removexattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S removexattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b32 -S setxattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S setxattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S setxattr -F auid>=1000 -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S setxattr -F auid=0 -F key=perm_mod
EOL

# privileged.rules
cat <<EOL > "$DEST_DIR/privileged.rules"
-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/at -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/chage -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/chfn -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/chsh -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/crontab -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/gpasswd -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/mount -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/newgidmap -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/newgrp -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/insmod -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/newuidmap -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/sbin/postdrop -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/sbin/postqueue -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/ssh-agent -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged-ssh-agent
-a always,exit -F path=/usr/bin/su -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/sudo -F perm=x -F auid>=1000 -F auid!=unset -F key=privilege
-a always,exit -F path=/usr/bin/sudoedit -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/bin/umount -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/sbin/unix_chkpwd -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
-a always,exit -F path=/usr/lib/openssh/ssh-keysign -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
EOL

# session.rules
cat <<EOL > "$DEST_DIR/session.rules"
-w /var/run/utmp -p wa -k session
-w /var/log/btmp -p wa -k session
-w /var/log/wtmp -p wa -k session
EOL

# setgid.rules
cat <<EOL > "$DEST_DIR/setgid.rules"
-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -F key=setgid
-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -F key=setgid
EOL

# setuid.rules
cat <<EOL > "$DEST_DIR/setuid.rules"
-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -F key=setuid
-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -F key=setuid
EOL

# time-change.rules
cat <<EOL > "$DEST_DIR/time-change.rules"
-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -F key=time-change
-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -F key=time-change
EOL

# zmiana w pliku konfiguracyjnym /etc/audit/auditd.conf

# Plik konfiguracyjny auditd
CONFIG_FILE="/etc/audit/auditd.conf"

# Sprawdzenie, czy plik istnieje
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Plik konfiguracyjny $CONFIG_FILE nie istnieje."
    exit 1
fi

# Modyfikacja ustawień w pliku konfiguracyjnym
sed -i 's/^admin_space_left_action.*/admin_space_left_action = halt/' "$CONFIG_FILE"
sed -i 's/^max_log_file_action.*/max_log_file_action = keep_logs/' "$CONFIG_FILE"
sed -i 's/^space_left_action.*/space_left_action = email/' "$CONFIG_FILE"

# zmiana uprawnień do plików .rules
chmod 0640 /etc/audit/rules.d/*.rules

# restart usługi
systemctl restart auditd.service

echo -e "\nPliki .rules zostały utworzone i wypełnione regułami, dokonano zmiany w pliku etc/audit/auditd.conf."
