The app server called centos-host is running a Go app on the 8081 port. You have been asked to troubleshoot some issues with yum/dnf on this system, Install Nginx server, configure Nginx as a reverse proxy for this Go app, install firewalld package and then configure some firewall rules.
All the tasks require you to be root, so the first step is to become root

sudo -i

## Individual Steps ##
# Centos Host : Here we are required to diagnose why yum is not working, and fix it. This has to be done before we can do anything else!
# The error we get if we try to use yum to install a package indicates something is up with DNS resolution, to the first place to look is resolv.conf
# We note that there are no name servers defined, therefore this is the reason why nothing can be resolved.
# Fix DNS resolution
vi /etc/resolv.conf
# Add Google nameserver as the first line in the file and save
nameserver 8.8.8.8

# Packages 
# Install "nginx" package
yum install -y nginx

# Install "firewalld" package
yum install -y firewalld

# Security
# Start and Enable "firewalld" service.
systemctl enable firewalld
systemctl start firewalld

# Add firewall rules to allow only incoming port "22", "80" and "8081" The firewall rules must be permanent and effective immediately.
# Add firewall rules, make permanent and effective.
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=8081/tcp --permanent
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --reload

# Go App : Start GoApp by running the "nohup go run main.go &" command from "/home/bob/go-app/" directory
pushd /home/bob/go-app
nohup go run main.go &
popd

# You can use the following to determine when the go app is fully started. Re-run it periodically till the grep returns a match.
# Check go app is running
ps -faux | grep -P '/tmp/go-build\d+/\w+/exe/main'

# Nginx: Configure Nginx as a reverse proxy for the GoApp so that we can access the GoApp on port "80"
vi /etc/nginx/nginx.conf

# At line 48 insert the following line after location / {

            proxy_pass  http://localhost:8081;

# Start and Enable "nginx" service
systemctl enable nginx
systemctl start nginx

# bob: Click the GoApp button above the terminal. You should get a login screen.





##  Using script ##

# type :
sudo -i
vi challenge2.sh
# copy the script challenge1.sh into centos server of your lab and type escape +:wq  to save

# Add exection permission:
chmod +x challenge2.sh

# Run the script:
./challenge2.sh



# Do a check to Verify



# Enjoy
