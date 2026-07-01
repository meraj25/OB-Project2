CREATE TABLE users (user_id SERIAL PRIMARY KEY, name VARCHAR(100), password VARCHAR(255), role VARCHAR(25) );
--CREATE TABLE

CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY, 
    title VARCHAR(50), description VARCHAR(255), 
    status Varchar(25) NOT NULL DEFAULT 'To Do' CHECK(status IN('To Do','In Progress', 'Done')),
    created_by INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, 
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP );
--CREATE TABLE

CREATE TABLE task_assignees(task_id INT NOT NULL REFERENCES tasks(task_id) ON DELETE CASCADE, user_id INT NOT NULL REFERENCES users(user_id),PRIMARY KEY(task_id,user_id));
--CREATE TABLE

##why the assignees relationship needs its own table?

--There might be one or more assignees for a task, but if we try to insert more than one users to a single task it won't be allowed and therefore 
--for the same task there will be more duplicate records.and also we cant store combined ids of users allocated for a single task in a single row
--like (2,1) which is not a real id in the users table therefore the best approach is to create a seperate join table to store assignees data.