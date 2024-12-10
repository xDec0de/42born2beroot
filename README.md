# 42 - Born2beroot

A guide to setup a simple Debian server with a monitoring script

# About this guide

This guide has been made in order to showcase what I did for this project.
I strongly recommend to do the project on your own without any guide,
you will learn a lot more if you do this project by yourself. That being
said, this is how I did it, with the goal of getting a 125/125 score.

# The operating system

Before we even start to make the project, we should choose the right
OS for it, we have to options: **Rocky** and **Debian**.

I decided to use Debian because I'm already familiar with it, that's the
only reason, yes, at least for me that is.

# What is a Virtual Machine and how to create one

Before we create a Virtual Machine, we should now what that is and why
are we creating one, we are going to use VirtualBox for that. Now, a
Virtual Machine (VM) is basically a virtually separated environment from
our main OS. This means that we can have more than one OS running at the
same time on the same machine without having to deal with partitions or
anything like that. This is also meant to fully separate the environments
so each has its own resources and works separately to the other.

Now that we have the theory, let's go to the practice. First, we need
to download the ISO image for the OS that we want, in my case, the latest
stable build of Debian, which can be found
[here](https://www.debian.org/download).

Now that we have the ISO image, we can create a new Virtual Machine just
like this:

![image](https://github.com/user-attachments/assets/3353ef25-2fb4-4f06-b8dd-0729ed17da70)

Remember to check the "Skip Unattended Instalation" box, as we will of
course do all of the instalation manually. Click on **next** and select
the amount of resources for the VM:

![image](https://github.com/user-attachments/assets/60c1c594-ffd5-49d3-af0e-8239498f3a52)

Now it's time to create a virtual disk. This is where all of the information
of our VM will be stored, so choose the amount wisely and keep in mind that
Debian itself takes some space, I'll try 15GB:

![image](https://github.com/user-attachments/assets/013aa857-206c-4b22-93a2-e1148d16f75c)

Finally, verify that the information is correct and click on **Finish**.

# Debian installation

The very first time you start your VM, you will notice that the window is tiny. This can
be fixed by clicking `File -> Preferences... -> Display`
Then replicate the following settings:

![image](https://github.com/user-attachments/assets/311c1cf4-7a3f-4b15-bf99-dd905097fc87)

Click on **OK** and restart the VM, you should now have a decent screen size. Now let's
start with the actual OS installation. The very first time you run your VM, you should be
welcomed with a screen like this one:

![image](https://github.com/user-attachments/assets/3d8fc195-413a-4f1d-b2f4-c824aee4aa5e)

You can control this menu with your arrow keys, using the enter key to confirm. Now use
your down arrow key to select **Install** with enter, **NOT** Graphical install. This
should be the next screen, just hit enter to choose English.

![image](https://github.com/user-attachments/assets/151e98dd-2cd2-4739-8798-34140aa58950)

Then it will ask for your country, I just selected `Other -> Europe -> Spain`. Once you do
that it will ask for your locale, you can just select `United States - en_US.UTF-8`.
Keymap is the next step, this is important as this is how the OS will handle your keyboard,
so I chose the `Spanish` keymap. Once you do all of those steps, Debian will begin to install.
This will take a few seconds, just wait until you are asked for a hostname

![image](https://github.com/user-attachments/assets/5d6afdd4-1751-474b-bb72-336a8050e76d)

Your hostname must be `login42`, in my case, as my login is `daniema3`, my hostname will be
`daniema342`. You can then leave the domain name empty and choose a very strong and safe
password for root. Mine will be `potato`, which is undeniably strong. You will be asked to
re-enter the password, then to choose the full name of the new user, just use your login,
so `daniema3` for me, same for the username, then I will use the same very strong password
for this user. Once you do this, it will ask for your time zone. I obviously selected
`Madrid`.

## Disk partitions

Here is where the fun begins, sort of. Select `Manual`

![image](https://github.com/user-attachments/assets/d82807fa-e15a-4776-94b2-bd1babd63a84)

Then select `SCSI3 (0,0,0) (sda) - X.X GB ATA VBOX HARDDISK -> <Yes>`, then
`pri/log X.X GB FREE SPACE -> Create a new partition -> 500 MB -> Primary -> Beginning ->
Mount point -> /boot -> Done setting up the partition`.

You will notice that now you have one partition, so let's create another one like this:
`pri/log X.X GB FREE SPACE -> Create a new partition -> max -> Logical -> Mount point ->
Mount point -> Do not mount it -> Done setting up the partition`.

This leaves us with the partitions for the **bonus part** ready. Now we need to encrypt
the disks. Move up to `Configure encrypted volumes -> Yes -> Create encrypted volumes`.
**ONLY SELECT SDA5** (You can select with space by the way)

![image](https://github.com/user-attachments/assets/6dd39a50-2648-4230-a1dd-bb30b3daf9da)

`Done setting up the partition -> Finish -> <Yes>`. This will now take a while as Debian
is creating and encrypting our partitions, just be patient and take a break. This is the
perfect time to wonder if you are just following a guide or if you are actually learning.

Once it finishes loading, it will ask you for a Encription passphrase, I will use my very
strong and reliable password once again. It warns me that it is weak, but that's a lie!

## Logical Volume Manager (LVM)

This is the very last (long) step for our installation, _don't panic_. Just go to
`Configure the Local Volume Manager -> Yes -> Create volume group` Enter `LVMGroup` as
the group name, `Continue`, select `/dev/mapper/sda5_crypt`, press **enter**, now let's
actually create the logical volumes

- Create logical volume -> LVMGroup -> root -> 2.8G
- Create logical volume -> LVMGroup -> home -> 2G
- Create logical volume -> LVMGroup -> swap -> 1G
- Create logical volume -> LVMGroup -> tmp -> 2G
- Create logical volume -> LVMGroup -> srv -> 1.5G
- Create logical volume -> LVMGroup -> var -> 2G
- Create logical volume -> LVMGroup -> var-log -> 2G

`Display configuration settings` should look something like this

![image](https://github.com/user-attachments/assets/d98dfa1c-1c1b-47ac-9ccb-9b9acf9327d6)

Once you confirm that your settings match select `Continue`, then `Finish`. Now you will
see a list with all of the logical volumes you created, you can identify them by this
format: `LVM VG LVMGroup, LV <name> ...`, that "name" being the part that identifies the
group. Knowing that, you can follow this list, volumes are identified by name:

- `home -> #1 X GB -> Use as: ... -> Ext4 ... -> Mount point: ... -> /home -> Done`
- `root -> #1 X GB -> Use as: ... -> Ext4 -> Mount point -> / -> Done`
- `srv -> #1 X GB -> Use as: ... -> Ext4 -> Mount point -> /srv -> Done`
- `swap -> #1 X GB -> Use as: ... -> swap area -> Done`
- `tmp -> #1 X GB -> Use as: ... -> Ext4 -> Mount point -> /tmp -> Done`
- `var -> #1 X GB -> Use as: ... -> Ext4 -> Mount point -> /var -> Done`
- `var-log -> #1 X GB -> Use as: ... -> Ext4 -> Mount point -> Enter manually -> /var/log -> Done`

Once done, your setup should look something like this:

![image](https://github.com/user-attachments/assets/fe95f3e9-8578-4a1d-9508-6bff0d8f61c8)

Now just scroll down and select `Finish partitioning and write changes to disk -> Yes`
This will once again take some time. Yes, this project is tedious.

After waiting for some time, you will be asked to scan extra installation media, just
kindly deny the offer by selecting `<No>`, now choose country and mirror. I selected
`Spain -> deb.debian.org`, leave proxy blank and select `Continue`. Wait again :D

Once again kindly deny to participate in surveys by selecting `No`, uncheck everything
as we will install things manually. `Yes -> /dev/sda -> Continue`, Done! For now...
The VM should automatically restart after this. Note that every time you start the
VM you will need to enter the passphrase to unlock your disk.

## Hostname

Just in case you are using a wrong hostname for any reason, remember that you can change
it with `hostnamectl set-hostname <hostname>`, then, you can check your hostname by using
the `hostname` command. You will need to know how to do this on your evaluation.

## Sudo

Now it's time to install sudo _(**su**per **u**ser **do**)_, a very descriptive name.
This program is used to securily execute programs with the privileges of other users,
generally root privileges. You can of course just use the root use, but it is common
to install sudo instead. After this explanation, have you really thought about why
we created the partitions previously or were you just following the guide?

Alright, I will no longer remember you about researching every step. Now let's install
sudo, shall we? First, you must be in the **root** user, this can be acheived by
directly loggin in to the root user when you start the VM or just by running `su root`.
Once you have verified that you are using the root user, run the following commands:

```
apt update
apt upgrade
apt install sudo
```

Once installed, the subjet tells us to modify some things, we can do that by editing
the file **sudoers.tmp** with the `visudo` command, then you can add this to the
bottom of the file, yes, one tab is used for spacing:

```
Defaults     passwd_tries=3
Defaults     badpass_message="Wrong password :("
Defaults     logfile="/var/log/sudo/sudo.log"
Defaults     log_input
Defaults     log_output
Defaults     requiretty
```

Just use _Ctrl + O_, _Enter_ and finally _Ctrl + X_ to save.
This applies the following configuration to sudo:

- Limit the sudo login attepts to 3.
- Modify the login error message _(You can customize it)_.
- Logs input and output to the /var/log/sudo/sudo.log file.
- Enable **TTY** mode.

The `/var/log/sudo` should exist, if not, create it. Please avoid creating it at
`/root/var/log/sudo` as I almost did. To verify that this works you can run some
command with sudo, like `sudo pwd`, then run `cat var/log/sudo/sudo.log` to see
the contents of the file. It should look something like this:

![image](https://github.com/user-attachments/assets/ce5b82bd-e8f9-4f4f-8f74-9eec05e7bed1)

Also, remember to add your user (In my case daniema3) to sudo. You can do that
by running `sudo usermod -aG sudo <user>` directly from the root user.

## Groups

At this point you should have all required users root and a user with your login.
However, as stated by the subject, your user (The one with your login) must be
part of the **sudo** and **user42** groups. By executing `groups` with your user,
you can see that it doesn't belong to said groups, but rather something like this
(In my case)

```
daniema3 cdrom floppy sudo audio dip video plugdev users netdev
```

The sudo group already exists and is assigned to all sudo users, so we just need
to create the **user42** group, to do that just execute `groupadd user42`.
To add the user to the **user42** log back into root with `su root` and run
`gpasswd -a <user> user42`, then log into your user and use `groups` to check the
groups of your user. The reason why we log into root and then log back into our
user is because I noticed that using `groups` with out doing that may cause it
to not be updated for some reason. Anyways, the new output should be this one:

```
daniema3 cdrom floppy sudo audio dip video plugdev users netdev user42
```

## UFW

Time for UFW _(**U**ncomplicated **F**ire**w**all)_. The subject tells us to open
**ONLY** the port 4242, so that's what we are going to do. UFW allows us to add restrictions
on which ports of our server can be accessed by closing and opening them. But first, we must
install it with `sudo apt install ufw`. You will be asked if you really want to install it,
just type _Y_ and hit _enter_ to confirm. Once installed run `sudo ufw enable` to enable, you
should receive a confirmation message saying _"Firewall is active and enabled on system
startup"_. If everything went right, run `sudo ufw allow 4242` to open the 4242 port,
finally `sudo ufw status` should output this:

![image](https://github.com/user-attachments/assets/0744cee4-f1f4-43a8-b031-60ea170d3911)

That's all. You may want to do your own research on how to open and close ports, remove
rules and why the status command outputs two rules when we only added one.

## SSH

A nice and standard way to remotely connect to our server is SSH _(**S**ecure **Sh**ell or
**S**ecure **S**ocket **S**hell)_. Once again I'll let you do your research on it instead
of explaining. To install it run `sudo apt install openssh-server`. It will ask for
confirmation just as UFW did, type _Y_ and hit _enter_. To confirm that SSH was installed
correctly on our system we can run `sudo systemctl status ssh`, it should output something
like this:

![image](https://github.com/user-attachments/assets/71f69ef2-6115-49a0-8c5e-982e936ed303)

Now, by default, SSH listens at port **22**. The subject tells us to restrict root login via
SSH and to listen at port 4242 (The one that we previously opened with UFW, not a coincidence).
To do this, we must edit the _/etc/ssh/sshd_config_ file with any editor, I'll just use
`sudo nano /etc/ssh/sshd_config`. Take special care with the file name as there are files with similar
names on that directory.

Find line `#Port 22` and change it to `Port 4242` (Yes, you must remove the _#_). Save
the file and run `sudo systemctl restart ssh`.

Outside of your VM, (On the host machine), you can run `ssh <your_user>@localhost -p 4242`
to connect via SSH to your own VM. If it fails, is may be because you need to forward the
4242 port on VirtualBox. go to
`<Your VM name> -> Settings -> Network -> Adapter 1 -> Advanced-> Port Forwarding`.

![image](https://github.com/user-attachments/assets/0ad8ac33-25ca-4e2a-ba06-c98d2016ec2e)

Add a new rule `Host port 4242 and guest port 4242` _(To add rules click that tiny little
green button, took me a few seconds to notice)_:

![image](https://github.com/user-attachments/assets/ae1929f4-628b-4b69-8242-f2b67db77ad0)

If this still doesn't let you connect to your VM, and more specifically if you are a
42 MADRID student, this may be because they are still using port 4242 on this campus for
whatever reason, you can verify that this is the case by connecting with the `-vvv` flags,
if you are having this error, you should see something like this:

![image](https://github.com/user-attachments/assets/0167b56e-b3bc-4804-9987-95b3169cead7)

That's an HTML header! It means that we are trying to connect to ssh but we are instead
connecting to a web service. This is not something you can change as it is not part of
your VM nor in your power to be changed as far as I know, the accepted solution in this
case by staff is to use port **4243**. This is a issue I had that make me loose a couple
of hours. On a side note, if you are curious, you can indeed connect to `localhost:4242`
on your browser, a white page with the text "{'ftpkg-srv'}" should appear. Weird.

## Password policy

The subject asks us to make a strict password policy to protect our sever accounts, sadly,
my very secure **potato** password doesn't comply with this policy for some weird reason.
Anyways, here is the list of requirements:

- Passwords must expire after 30 days.
- 2 days must pass in order to be able to change a password again.
- The user must be reminded 7 days before the password expires.
- The password must be at least 10 characters long, contain an upper and lower case
  character, a number and can't contain the same character 3 times consecutively.
- Passwords can't contain the username.
- New passwords must have at least 7 characters that aren't the same as the old password
  (This rule doesn't apply for root)
- All existing users must have their password updated to comply with the policy (root included)

To do this we can open `/etc/login.defs` for the first three requirements, which are all
related to how the password ages, just search for and change the following:

```
PASS_MAX_DAYS 30
PASS_MIN_DAYS 2
PASS_WARN_AGE 7
```

PASS_WARN_AGE normally defaults to 7 so most likely you won't even need to change it, however,
these changes are not applied to existing users, so you must apply them manually with the
following commands, root included.

```
$ sudo chage -M 30 <user>
$ sudo chage -m 2 <user>
$ sudo chage -W 7 <user>
```

Once you are done, you can verify the values for each user with `chage -l <user>`.

For the remaining steps we need to install a password validation library. You can do so
by running `sudo apt install libpam-pwquality`. Once installed, edit the
`/etc/security/pwquality.conf` to match this:

```
# ...
difok = 7
# ...
minlen = 10
# ...
dcredit = -1
# ...
ucredit = -1
# ...
maxrepeat = 3
# ...
usercheck = 1
# ...
retry = 3
# ...
enforce_for_root
```

Yes, you need to remove the '#' characters in order to uncomment the line so it takes
effect, and yes, the `enforce_for_root` option has no value and you must only remove the
'#' character. Remember to update all passwords to comply with the policy and you are done.
By the way, my new password is AmazingPotato123.

## Monitoring script

This script can be found on this repository, yes. But I encourage you to make your own as
most likely you will be asked abot how your script works, however, here are some useful
commands and files that will help you to get all the data you need:

- `wall`: Broadcast a message to all users in all terminals
- `uname`: Architecture information
- `cat /proc/cpuinfo`: CPU information
- `free`: RAM information
- `df`: Disk information
- `top -bn1`: Process information
- `who`: Last boot and connected user information
- `lsblk`: Partition and LVM information
- `cat /proc/net/sockstat`: TCP information
- `hostname`: Hostname and IP information
- `ip link show` or `ip address`: IP and MAC information

Remember to add execution permissions to your **monitoring.sh** script and to put it
on the /root directory. I just used `chmod 777 monitoring.sh`. To "enable" the script
we can use crontab. Just run `systemctl enable cron` to enable cron, then edit it
with `crontab -e`. The first time you run this command it will ask you to choose an
editor, you can just run nano and add this line to the file:

```
*/10 * * * * bash /root/monitoring.sh
```

Save and done. That's everything you need to do on the VM besides checking if the
script runs every 10 minutes as expected, you could of course reduce the time to one
minute to avoid waiting, just remember to change it back again.
