# Pokedex

## Requirements
- Ruby 3.3.2
- node 20.5.0
- SQLite 3

## Setup
- It is necessary to set the following environment variables (.env) before running the server: `MISSION_CONTROL_USER` and `MISSION_CONTROL_PASSWORD`
```sh
$ bundle install
$ yarn install
$ bin/rails db:prepare
$ bin/rails db:seed
$ bin/rails assets:precompile
$ bin/rails server
```
- Access the login page through http://localhost:3000/app/login

## Screenshots

### Admin login
![Admin login](https://github.com/user-attachments/assets/93dd5462-5d99-45cc-9c9a-78aa5bcec3a9)

### Edit and delete pokemon
![Edit and delete pokemon](https://github.com/user-attachments/assets/0dfc8017-3b8a-4d53-9384-ebb7ab16aa01)

### Show pokemon
![Show pokemon](https://github.com/user-attachments/assets/8b40465e-ab21-42ff-ac64-49f71e02e685)

### Search pokemon
![Search pokemon](https://github.com/user-attachments/assets/6054bd35-a357-41b3-93d8-9e9cee9b4283)

### Add and show trainer
![Add and show trainer](https://github.com/user-attachments/assets/59624269-5c3b-423f-b8fa-c356e80df8f6)

### Edit and delete trainer
![Edit and delete trainer](https://github.com/user-attachments/assets/87111cae-bb5d-4958-a999-77724c1691bf)

### Search trainer
![Search trainer](https://github.com/user-attachments/assets/1aaeb4b8-b60f-4f06-989a-0753958c41a5)

### Trainer login
![Trainer login](https://github.com/user-attachments/assets/b09731d9-c894-45c3-8e7a-d63ce9c330cb)

### Catch pokemon
![Catch pokemon](https://github.com/user-attachments/assets/e1fd0d5e-22c3-471c-9bd4-1357c6fa66e9)
