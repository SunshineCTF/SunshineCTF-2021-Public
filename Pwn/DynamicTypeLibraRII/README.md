# DynamicTypeLibraRII
My challenge for SunshineCTF 2021

# How to run

Either cd to `deploy` and run `docker-compose --project-name dynamic_type_librarii up --build` or run the convenience script `./deploy.sh`

# What to provide

The files in `dist` should be provided. They should be up to date, but they will automatically be rebuilt when `docker-compose up` is run to ensure competitors have the most recent files.

# Description

The description added to CTFd is in `description.md`

# Solver

The solver is in `solve` if you need a health check set host and port appropriately.

# Port

Right now, the challenge runs on port 21001. If you want to change the port *only change the external port* in `docker-compose.yml`.
