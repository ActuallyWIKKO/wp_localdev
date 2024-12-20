Prerequisites:
- Everytime I use braces in these commands ommit them when inserting the needed values.
- To avoid errors please make sure to pay extra attentionn to spaces and dashes.

You'll need this:
- Docker (Desktop)
- Docker Compose

1. Clone the repository to a new folder
- git clone {URL TO GIT FILE} {YOUR FOLDER NAME}
2. Build the docker image & run the container
- docker-compose build 
- docker-compose run -d
3. Find the wordpress container ID & enter the container
- docker ps
3.1 Create a Database
  - docker exec -it {CONTAINER-ID} mysql -u root
  - CREATE DATABASE {YOURDBNAME};
  - exit
4. Use the WP CLI to delete default plugins and themes then download your theme from Github
 - docker exec -it {CONTAINER ID} /bin/bash
- wp plugin list --status=inactive --field=name --allow-root --path=/var/www/html | xargs -n1 wp plugin delete --allow-root
- wp theme list --status=inactive --field=name --allow-root --path=/var/www/html | xargs -n1 wp theme delete --allow-root
- wp theme install {URL TO THEME ZIP FILE} --activate --allow-root --path=/var/www/html

With these basic setup steps done, you can now go to your localhost on port 3002, complete the 2-step Wordpress install
and start developing your theme/plugin. 

I use mine for developing and testing for our customers and to prepare my own headless system with a Vue-based frontend.

What mounts are available outside the container:
- ./_dist/:/var/www/html/_dist/
- ./docker-files/wp-config.php:/var/www/html/wp-config.php
- ./wp-content/plugins/:/var/www/html/wp-content/plugins/
- ./wp-content/themes/:/var/www/html/wp-content/themes/

Use _dist for headless setups. Adjust mounts as needed.

Optionally use this for the initial setup
  command: --skip-grant-tables
in the database section of the docker-compose to skip authentication checks.

These commands can change depending on the image used. For example on arm7 architecture the image I tried for mariadb used sh instead of bash.
