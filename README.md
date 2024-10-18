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
