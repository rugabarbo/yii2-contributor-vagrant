It's ready to use Yii2 playground that can be handy for Yii2 contributors.

Installation
------------

#### Manual for Linux/Unix users

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. Install [Vagrant](https://www.vagrantup.com/downloads.html)
1. Do the [first](https://github.com/yiisoft/yii2/blob/master/docs/internals/git-workflow.md#1-fork-the-yii-repository-on-github-and-clone-your-fork-to-your-development-environment) 
and [second](https://github.com/yiisoft/yii2/blob/master/docs/internals/git-workflow.md#2-add-the-main-yii-repository-as-an-additional-git-remote-called-upstream)
steps according to the [Yii2 contributor guide](https://github.com/yiisoft/yii2/blob/master/docs/internals/git-workflow.md#git-workflow-for-yii-2-contributors)
1. Create GitHub [personal API token](https://github.com/blog/1509-personal-api-tokens)
1. Prepare project:
   
   ```bash
   git clone https://github.com/rugabarbo/yii2-contributor-vagrant.git
   cd yii2-contributor-vagrant/vagrant/config
   cp vagrant-local.example.yml vagrant-local.yml
   ```
   
1. Place your GitHub personal API token to `vagrant-local.yml`
1. Place path to your local yii2 repository to `vagrant-local.yml` (by default it's `../yii2`)
1. Change directory to project root:

   ```bash
   cd yii2-contributor-vagrant
   ```

1. Run command:

   ```bash
   vagrant up
   ```
   
That's all. You just need to wait for completion! 
After that you can access basic app (linked with Yii2 playground) locally by URLs: http://l.y2cv-basic-app.test
   
#### Manual for Windows users

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. Install [Vagrant](https://www.vagrantup.com/downloads.html)
1. Reboot
1. Do the [first](https://github.com/yiisoft/yii2/blob/master/docs/internals/git-workflow.md#1-fork-the-yii-repository-on-github-and-clone-your-fork-to-your-development-environment) 
and [second](https://github.com/yiisoft/yii2/blob/master/docs/internals/git-workflow.md#2-add-the-main-yii-repository-as-an-additional-git-remote-called-upstream)
steps according to the [Yii2 contributor guide](https://github.com/yiisoft/yii2/blob/master/docs/internals/git-workflow.md#git-workflow-for-yii-2-contributors)
1. Create GitHub [personal API token](https://github.com/blog/1509-personal-api-tokens)
1. Prepare project:
   * download repo [rugabarbo/yii2-contributor-vagrant](https://github.com/rugabarbo/yii2-contributor-vagrant/archive/master.zip)
   * unzip it
   * go into directory `yii2-contributor-vagrant-master/vagrant/config`
   * copy `vagrant-local.example.yml` to `vagrant-local.yml`

1. Place your GitHub personal API token to `vagrant-local.yml`
1. Place path to your local yii2 repository to `vagrant-local.yml` (by default it's `../yii2`)
1. Open terminal (`cmd.exe`), **change directory to project root** and run command:

   ```bash
   vagrant up
   ```
   
   (You can read [here](http://www.wikihow.com/Change-Directories-in-Command-Prompt) how to change directories in command prompt) 

That's all. You just need to wait for completion! 
After that you can access basic app (linked with Yii2 playground) locally by URLs: http://l.y2cv-basic-app.test
