# 42 - Born2beroot

A guide to setup a simple Debian server with a monitoring script

# About this guide

This guide has been made in order to showcase what I did for this project.
I strongly recommend to do the project on your own without any guide,
you will learn a lot more if you to this project by yourself. That being
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
Debian itself takes some space:

![image](https://github.com/user-attachments/assets/11739fe1-fdcb-49e7-b7f8-66d28c1df257)

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

![image](https://github.com/user-attachments/assets/16cbcdc9-2c3e-41c8-b829-5e38864a2805)

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

- Create Logical Volume -> LVMGroup -> root -> 2.8G
- Create Logical Volume -> LVMGroup -> home -> 2G
- Create Logical Volume -> LVMGroup -> swap -> 1G
- Create Logical Volume -> LVMGroup -> tmp -> 2G
- Create Logical Volume -> LVMGroup -> srv -> 1.5G
- Create Logical Volume -> LVMGroup -> var -> 2G
- Create Logical Volume -> LVMGroup -> var-log -> 2G

`Display configuration settings` should look something like this: (TODO: UPDATE PARTITION SIZES)

![image](https://github.com/user-attachments/assets/c591959f-aa70-43ed-b449-f2da55229bb9)
