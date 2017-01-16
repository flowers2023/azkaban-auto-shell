# azkaban-auto-shell
脚本化自动创建、更新azkaban上的project
config.prop里配置azkaban的url地址，登陆的用户名和密码

创建和更新默认都是使用当前目录名作为项目名

# example
shuangfu@drunk:azkaban-auto-shell$ sh azkaban.sh --create
则会创建的项目名为：azkaban-auto-shell
shuangfu@drunk:azkaban-auto-shell$ sh azkaban.sh

则会更新当前目录里的文件到项目【azkaban-auto-shell】中
