#自动更新google host

目前只测试了OXS系统，可以正常更新，windows系统需要修改host文件位置，再执行脚本

##使用
	
* 1、安装ruby运行环境

* 2、使用git下载本项目到本地 

	git clone git@github.com:fxhover/update_google_hosts.git

* 3、进入项目目录执行更新

	sudo ruby update_google_hosts.rb

* 4、删除google hosts

 
	sudo ruby update_google_hosts.rb delete