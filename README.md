# NaMa - Not another Membership administration

## General information

This is the ZHAW semester project developed by Sandra Freihofer.

## System requirements

* Ruby 1.9.3p194
* Rails 3.2.8
* SQLite3 1.3.6

## Quick start

* Clone the repo, `git clone git://github.com/sfreihofer/nama.git`
* Execute following:

```
$ cd nama
$ mv config/app_config.yml.example config/app_config.yml
$ bundle install
$ rake db:migrate
$ rake db:seed
```

* With a web browser access `http://localhost:3000`
* Sign in as user `nama` with password `default`
* **Note:** For successful user signup you have to make changes to `config/app_config.yml` for email notifications

### Example Gmail setup

```
development:
  mail:
    delivery_method: :smtp
    smtp_settings:
      address: smtp.gmail.com
      port: 587
      user_name: <username>
      password: <password>
      authentication: plain
      enable_starttls_auto: true
  domain: localhost:3000
```

## License

This software is distributed under the GNU General Public License, version 2 - see the
accompanying COPYING file for more details.
