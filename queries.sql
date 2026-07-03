--Note! - Updated the  users table by dropping the "role" column and tasks table by adding a new column as "updated_at"

CREATE EXTENSION IF NOT EXISTS pgcrypto;
--CREATE EXTENSION
INSERT INTO users(name,password) VALUES ('Kasun Bandara',crypt('kasun@123',gen_salt('bf')));
--INSERT 0 1
INSERT INTO users(name,password) VALUES ('Dasun Ekanayaka',crypt('Dasun@123',gen_salt('bf'))),
('Chamath Abeykoon',crypt('Chamath@123',gen_salt('bf'))),
('Ravindu Tharanga',crypt('Ravindu@123',gen_salt('bf'))),
('Pathum Dissanayaka',crypt('Pathum@123',gen_salt('bf')));
--INSERT 0 4
SELECT * FROM users;
-- user_id |        name        |                           password
-----------+--------------------+--------------------------------------------------------------
--       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi.
--       2 | Amal Basnayaka     | $2a$06$e1JUL4sLFUN40wa1JPVLveNTbJGzga2HdwTnh4qQ5wwx3.r4xDpdq
--       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC
--       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO
--       5 | Dasun Ekanayaka    | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS
--       6 | Chamath Abeykoon   | $2a$06$drGPgnnsk9nZR8i3i3A5Met.4JM0eBqkX.hlJcTmfxoViiLUEntRu
--       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K
--       8 | Pathum Dissanayaka | $2a$06$EoRbrWFRKxWXDfRE1ozUx.h3wbQJe7U9B/IFoV0VysbLUZnIyKSom
--(8 rows)
INSERT INTO tasks(title,description,created_by) VALUES 
('Fix login bug', 'Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling.',3),
('Set up CI pipeline', 'Configure GitHub Actions to run lint and tests automatically on every pull request.',4),
('Optimize DB queries', 'Task list endpoint is slow with 1000+ rows. Add indexes and review N+1 query issues.', 2),
('Write API documentation', 'Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.', 1),
('Fix CORS error on upload', 'File upload requests from the frontend are being blocked by CORS policy on the backend.', 5),
('Add dark mode toggle', 'Implement a dark/light theme switcher using Tailwind CSS and persist the choice in local storage.', 6),
('Refactor auth middleware', 'Clean up JWT verification logic and separate it from the route handlers for reusability.', 7),
('Deploy staging environment', 'Set up a staging server on Render separate from production for QA testing.', 8),
('Fix mobile responsive layout', 'Sidebar overlaps main content on screens smaller than 768px width.', 3),
('Update password hashing', 'Migrate password storage from plain crypt to bcrypt for stronger security.', 1),
('Implement rate limiting', 'Add request rate limiting on public API routes to prevent abuse and brute force attempts.', 4),
('Fix memory leak in worker', 'Background job worker memory usage grows steadily over 24 hours and eventually crashes.', 7),
('Add unit tests for auth', 'Write Jest test coverage for login, register, and token refresh flows.', 5),
('Migrate to TypeScript', 'Convert remaining JS files in the backend to TypeScript for better type safety.', 3),
('Set up error monitoring', 'Integrate Sentry to track and alert on unhandled exceptions in production.', 8),
('Fix pagination bug', 'Task list pagination skips records when items are deleted between page loads.', 5),
('Add email notifications', 'Send an email when a user is assigned to a new task using Nodemailer.', 6),
('Improve error messages', 'Replace generic 500 errors with descriptive messages for common validation failures.', 4),
('Set up database backups', 'Configure automated daily backups for the production PostgreSQL database.', 1),
('Fix duplicate task creation', 'Double-clicking submit button creates two identical tasks due to missing debounce.', 3),
('Add search functionality', 'Implement full text search on task title and description fields.', 2),
('Review and rotate secrets', 'Old API keys and JWT secrets committed to git history need to be rotated.', 7),
('Add role based access control', 'Restrict admin only routes like user management to users with role = admin.', 6),
('Fix timezone display bug', 'Due dates show in UTC instead of the logged in user local timezone.', 7),
('Set up load testing', 'Use k6 or Artillery to test API performance under concurrent user load.', 8),
('Add task comments feature', 'Allow users to leave comments on a task for team discussion and updates.', 4),
('Fix broken image uploads', 'Profile picture uploads over 2MB fail silently without showing an error to the user.', 5),
('Audit npm dependencies', 'Run npm audit and update packages with known security vulnerabilities.', 2),
('Add dark mode for mobile app', 'Extend the existing dark mode toggle to the React Native mobile client.', 3),
('Improve query caching', 'Add Redis caching layer for frequently accessed task list queries.', 1);

--INSERT 0 30

SELECT * FROM tasks;

task_manager=# SELECT * FROM tasks;
-- task_id |             title             |                                              description                                              | status | created_by |         created_at         |         updated_at
-----------+-------------------------------+-------------------------------------------------------------------------------------------------------+--------+------------+----------------------------+----------------------------
--       1 | Fix login bug                 | Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling. | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       3 | Optimize DB queries           | Task list endpoint is slow with 1000+ rows. Add indexes and review N+1 query issues.                  | To Do  |          2 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       4 | Write API documentation       | Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.                      | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       5 | Fix CORS error on upload      | File upload requests from the frontend are being blocked by CORS policy on the backend.               | To Do  |          5 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       6 | Add dark mode toggle          | Implement a dark/light theme switcher using Tailwind CSS and persist the choice in local storage.     | To Do  |          6 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       7 | Refactor auth middleware      | Clean up JWT verification logic and separate it from the route handlers for reusability.              | To Do  |          7 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       8 | Deploy staging environment    | Set up a staging server on Render separate from production for QA testing.                            | To Do  |          8 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       9 | Fix mobile responsive layout  | Sidebar overlaps main content on screens smaller than 768px width.                                    | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      10 | Update password hashing       | Migrate password storage from plain crypt to bcrypt for stronger security.                            | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      11 | Implement rate limiting       | Add request rate limiting on public API routes to prevent abuse and brute force attempts.             | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      12 | Fix memory leak in worker     | Background job worker memory usage grows steadily over 24 hours and eventually crashes.               | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      13 | Add unit tests for auth       | Write Jest test coverage for login, register, and token refresh flows.                                | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      15 | Set up error monitoring       | Integrate Sentry to track and alert on unhandled exceptions in production.                            | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      16 | Fix pagination bug            | Task list pagination skips records when items are deleted between page loads.                         | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      17 | Add email notifications       | Send an email when a user is assigned to a new task using Nodemailer.                                 | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      18 | Improve error messages        | Replace generic 500 errors with descriptive messages for common validation failures.                  | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      19 | Set up database backups       | Configure automated daily backups for the production PostgreSQL database.                             | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      20 | Fix duplicate task creation   | Double-clicking submit button creates two identical tasks due to missing debounce.                    | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      21 | Add search functionality      | Implement full text search on task title and description fields.                                      | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      22 | Review and rotate secrets     | Old API keys and JWT secrets committed to git history need to be rotated.                             | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      23 | Add role based access control | Restrict admin only routes like user management to users with role = admin.                           | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      24 | Fix timezone display bug      | Due dates show in UTC instead of the logged in user local timezone.                                   | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      25 | Set up load testing           | Use k6 or Artillery to test API performance under concurrent user load.                               | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      26 | Add task comments feature     | Allow users to leave comments on a task for team discussion and updates.                              | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      27 | Fix broken image uploads      | Profile picture uploads over 2MB fail silently without showing an error to the user.                  | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      29 | Add dark mode for mobile app  | Extend the existing dark mode toggle to the React Native mobile client.                               | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      30 | Improve query caching         | Add Redis caching layer for frequently accessed task list queries.                                    | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558                              	
--    (30 rows)

task_manager=# INSERT INTO task_assignees(task_id,user_id) VALUES (1,1),(1,4),(2,3),(2,5),(2,8),(3,1),(4,4),(4,5),(5,2),(5,7),(6,8),(7,2),(7,1),(8,3),(8,4),(9,5),(10,5),(10,7),(11,4),(12,1),(12,2),(13,2),(14,5),(14,6),(14,1),(15,8),(16,6),(17,3),(17,5),(18,1),(19,8),(20,3),(21,6),(21,5);
--INSERT 0 34
task_manager=# INSERT INTO task_assignees(task_id,user_id) VALUES (22,7),(22,4),(23,1),(24,6),(25,7),(25,3),(26,2),(27,5),(27,1),(28,3),(28,7),(28,2),(29,4),(30,5),(30,2);
--INSERT 0 15
task_manager=# SELECT * FROM task_assignees;

-- task_id | user_id
-----------+---------
--       1 |       1
--       1 |       4
--       2 |       3
--       2 |       5
--       2 |       8
--       3 |       1
--       4 |       4
--       4 |       5
--       5 |       2
--       5 |       7
--       6 |       8
--       7 |       2
--       7 |       1
--       8 |       3
--       8 |       4
--       9 |       5
--      10 |       5
--      10 |       7
--      11 |       4
--      12 |       1
--      12 |       2
--      13 |       2
--      14 |       5
--      14 |       6
--      14 |       1
--      15 |       8
--      16 |       6
--      17 |       3
--      17 |       5
--      18 |       1
--      19 |       8
--      20 |       3
--      21 |       6
--      21 |       5
--      22 |       7
--      22 |       4
--      23 |       1
--      24 |       6
--      25 |       7
--      25 |       3
--      26 |       2
--      27 |       5
--      27 |       1
--      28 |       3
--      28 |       7
--      28 |       2
--      29 |       4
--      30 |       5
--      30 |       2
--(49 rows)

SELECT * FROM users JOIN tasks ON users.user_id = tasks.created_by ORDER BY users.user_id;

--user_id |        name        |                           password                           | task_id |             title             |                                              description                                              | status | created_by |         created_at         |         updated_at
---------+--------------------+--------------------------------------------------------------+---------+-------------------------------+-------------------------------------------------------------------------------------------------------+--------+------------+----------------------------+----------------------------
--       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi. |       4 | Write API documentation       | Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.                      | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi. |      30 | Improve query caching         | Add Redis caching layer for frequently accessed task list queries.                                    | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi. |      10 | Update password hashing       | Migrate password storage from plain crypt to bcrypt for stronger security.                            | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi. |      19 | Set up database backups       | Configure automated daily backups for the production PostgreSQL database.                             | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       2 | Amal Basnayaka     | $2a$06$e1JUL4sLFUN40wa1JPVLveNTbJGzga2HdwTnh4qQ5wwx3.r4xDpdq |      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       2 | Amal Basnayaka     | $2a$06$e1JUL4sLFUN40wa1JPVLveNTbJGzga2HdwTnh4qQ5wwx3.r4xDpdq |       3 | Optimize DB queries           | Task list endpoint is slow with 1000+ rows. Add indexes and review N+1 query issues.                  | To Do  |          2 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       2 | Amal Basnayaka     | $2a$06$e1JUL4sLFUN40wa1JPVLveNTbJGzga2HdwTnh4qQ5wwx3.r4xDpdq |      21 | Add search functionality      | Implement full text search on task title and description fields.                                      | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC |       1 | Fix login bug                 | Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling. | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC |       9 | Fix mobile responsive layout  | Sidebar overlaps main content on screens smaller than 768px width.                                    | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC |      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC |      20 | Fix duplicate task creation   | Double-clicking submit button creates two identical tasks due to missing debounce.                    | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC |      29 | Add dark mode for mobile app  | Extend the existing dark mode toggle to the React Native mobile client.                               | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO |       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO |      18 | Improve error messages        | Replace generic 500 errors with descriptive messages for common validation failures.                  | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO |      26 | Add task comments feature     | Allow users to leave comments on a task for team discussion and updates.                              | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO |      11 | Implement rate limiting       | Add request rate limiting on public API routes to prevent abuse and brute force attempts.             | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS |      16 | Fix pagination bug            | Task list pagination skips records when items are deleted between page loads.                         | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS |      27 | Fix broken image uploads      | Profile picture uploads over 2MB fail silently without showing an error to the user.                  | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS |       5 | Fix CORS error on upload      | File upload requests from the frontend are being blocked by CORS policy on the backend.               | To Do  |          5 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS |      13 | Add unit tests for auth       | Write Jest test coverage for login, register, and token refresh flows.                                | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       6 | Chamath Abeykoon   | $2a$06$drGPgnnsk9nZR8i3i3A5Met.4JM0eBqkX.hlJcTmfxoViiLUEntRu |       6 | Add dark mode toggle          | Implement a dark/light theme switcher using Tailwind CSS and persist the choice in local storage.     | To Do  |          6 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       6 | Chamath Abeykoon   | $2a$06$drGPgnnsk9nZR8i3i3A5Met.4JM0eBqkX.hlJcTmfxoViiLUEntRu |      23 | Add role based access control | Restrict admin only routes like user management to users with role = admin.                           | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       6 | Chamath Abeykoon   | $2a$06$drGPgnnsk9nZR8i3i3A5Met.4JM0eBqkX.hlJcTmfxoViiLUEntRu |      17 | Add email notifications       | Send an email when a user is assigned to a new task using Nodemailer.                                 | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K |      12 | Fix memory leak in worker     | Background job worker memory usage grows steadily over 24 hours and eventually crashes.               | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K |       7 | Refactor auth middleware      | Clean up JWT verification logic and separate it from the route handlers for reusability.              | To Do  |          7 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K |      22 | Review and rotate secrets     | Old API keys and JWT secrets committed to git history need to be rotated.                             | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K |      24 | Fix timezone display bug      | Due dates show in UTC instead of the logged in user local timezone.                                   | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       8 | Pathum Dissanayaka | $2a$06$EoRbrWFRKxWXDfRE1ozUx.h3wbQJe7U9B/IFoV0VysbLUZnIyKSom |       8 | Deploy staging environment    | Set up a staging server on Render separate from production for QA testing.                            | To Do  |          8 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       8 | Pathum Dissanayaka | $2a$06$EoRbrWFRKxWXDfRE1ozUx.h3wbQJe7U9B/IFoV0VysbLUZnIyKSom |      25 | Set up load testing           | Use k6 or Artillery to test API performance under concurrent user load.                               | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       8 | Pathum Dissanayaka | $2a$06$EoRbrWFRKxWXDfRE1ozUx.h3wbQJe7U9B/IFoV0VysbLUZnIyKSom |      15 | Set up error monitoring       | Integrate Sentry to track and alert on unhandled exceptions in production.                            | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--(30 rows)

SELECT * FROM tasks JOIN users ON tasks.created_by = users.user_id ORDER BY task_id;

-- task_id |             title             |                                              description                                              | status | created_by |         created_at         |         updated_at         | user_id |        name        |                           password
-----------+-------------------------------+-------------------------------------------------------------------------------------------------------+--------+------------+----------------------------+----------------------------+---------+--------------------+--------------------------------------------------------------
--       1 | Fix login bug                 | Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling. | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC
--       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO
--       3 | Optimize DB queries           | Task list endpoint is slow with 1000+ rows. Add indexes and review N+1 query issues.                  | To Do  |          2 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       2 | Amal Basnayaka     | $2a$06$e1JUL4sLFUN40wa1JPVLveNTbJGzga2HdwTnh4qQ5wwx3.r4xDpdq
--       4 | Write API documentation       | Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.                      | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi.
--       5 | Fix CORS error on upload      | File upload requests from the frontend are being blocked by CORS policy on the backend.               | To Do  |          5 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS
--       6 | Add dark mode toggle          | Implement a dark/light theme switcher using Tailwind CSS and persist the choice in local storage.     | To Do  |          6 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       6 | Chamath Abeykoon   | $2a$06$drGPgnnsk9nZR8i3i3A5Met.4JM0eBqkX.hlJcTmfxoViiLUEntRu
--       7 | Refactor auth middleware      | Clean up JWT verification logic and separate it from the route handlers for reusability.              | To Do  |          7 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K
--       8 | Deploy staging environment    | Set up a staging server on Render separate from production for QA testing.                            | To Do  |          8 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       8 | Pathum Dissanayaka | $2a$06$EoRbrWFRKxWXDfRE1ozUx.h3wbQJe7U9B/IFoV0VysbLUZnIyKSom
--       9 | Fix mobile responsive layout  | Sidebar overlaps main content on screens smaller than 768px width.                                    | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC
--      10 | Update password hashing       | Migrate password storage from plain crypt to bcrypt for stronger security.                            | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681 |       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi.
--      11 | Implement rate limiting       | Add request rate limiting on public API routes to prevent abuse and brute force attempts.             | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO
--      12 | Fix memory leak in worker     | Background job worker memory usage grows steadily over 24 hours and eventually crashes.               | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K
--      13 | Add unit tests for auth       | Write Jest test coverage for login, register, and token refresh flows.                                | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS
--      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC
--      15 | Set up error monitoring       | Integrate Sentry to track and alert on unhandled exceptions in production.                            | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       8 | Pathum Dissanayaka | $2a$06$EoRbrWFRKxWXDfRE1ozUx.h3wbQJe7U9B/IFoV0VysbLUZnIyKSom
--      16 | Fix pagination bug            | Task list pagination skips records when items are deleted between page loads.                         | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS
--      17 | Add email notifications       | Send an email when a user is assigned to a new task using Nodemailer.                                 | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       6 | Chamath Abeykoon   | $2a$06$drGPgnnsk9nZR8i3i3A5Met.4JM0eBqkX.hlJcTmfxoViiLUEntRu
--      18 | Improve error messages        | Replace generic 500 errors with descriptive messages for common validation failures.                  | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO
--      19 | Set up database backups       | Configure automated daily backups for the production PostgreSQL database.                             | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi.
--      20 | Fix duplicate task creation   | Double-clicking submit button creates two identical tasks due to missing debounce.                    | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC
--      21 | Add search functionality      | Implement full text search on task title and description fields.                                      | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       2 | Amal Basnayaka     | $2a$06$e1JUL4sLFUN40wa1JPVLveNTbJGzga2HdwTnh4qQ5wwx3.r4xDpdq
--      22 | Review and rotate secrets     | Old API keys and JWT secrets committed to git history need to be rotated.                             | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K
--      23 | Add role based access control | Restrict admin only routes like user management to users with role = admin.                           | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       6 | Chamath Abeykoon   | $2a$06$drGPgnnsk9nZR8i3i3A5Met.4JM0eBqkX.hlJcTmfxoViiLUEntRu
--      24 | Fix timezone display bug      | Due dates show in UTC instead of the logged in user local timezone.                                   | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       7 | Ravindu Tharanga   | $2a$06$yCjnm6ZIzoqTqOBMLHeXjeRt0nuFXjlvqcITh/hECsKp0GByt5P6K
--      25 | Set up load testing           | Use k6 or Artillery to test API performance under concurrent user load.                               | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       8 | Pathum Dissanayaka | $2a$06$EoRbrWFRKxWXDfRE1ozUx.h3wbQJe7U9B/IFoV0VysbLUZnIyKSom
--      26 | Add task comments feature     | Allow users to leave comments on a task for team discussion and updates.                              | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       4 | Dasun Ekanayaka    | $2a$06$wZw.fjRxkSfxN2TPvVpoIO.9DHeIMc2LjQs/PTQNPhuKoUIT6r0RO
--      27 | Fix broken image uploads      | Profile picture uploads over 2MB fail silently without showing an error to the user.                  | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       5 | Akash Kumara       | $2a$06$Es1QyDA3qmiBizHxA8OojeZaePAWhNVinUh7Zq/AReLzFYEE3d2HS
--      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       2 | Amal Basnayaka     | $2a$06$e1JUL4sLFUN40wa1JPVLveNTbJGzga2HdwTnh4qQ5wwx3.r4xDpdq
--      29 | Add dark mode for mobile app  | Extend the existing dark mode toggle to the React Native mobile client.                               | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       3 | Nimal Perera       | $2a$06$epitTi9wTSvH7vfVX4KSQuB72FWjI6tXlGmIT0o71DI13I/zcQjTC
--      30 | Improve query caching         | Add Redis caching layer for frequently accessed task list queries.                                    | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558 |       1 | Kasun Bandara      | $2a$06$YAAw49LgeVwz0nXzckgnPe6xOY9bzGlz7ME6Xj/4HRj2vP4IFqJi.
--(30 rows)

SELECT * FROM task_assignees JOIN tasks ON task_assignees.task_id = tasks.task_id ORDER BY tasks.task_id;

-- task_id | assignees | task_id |             title             |                                              description                                              | status | created_by |         created_at         |         updated_at
-----------+-----------+---------+-------------------------------+-------------------------------------------------------------------------------------------------------+--------+------------+----------------------------+----------------------------
--       1 |         1 |       1 | Fix login bug                 | Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling. | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       1 |         4 |       1 | Fix login bug                 | Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling. | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       2 |         3 |       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       2 |         5 |       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       2 |         8 |       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       3 |         1 |       3 | Optimize DB queries           | Task list endpoint is slow with 1000+ rows. Add indexes and review N+1 query issues.                  | To Do  |          2 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       4 |         4 |       4 | Write API documentation       | Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.                      | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       4 |         5 |       4 | Write API documentation       | Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.                      | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       5 |         2 |       5 | Fix CORS error on upload      | File upload requests from the frontend are being blocked by CORS policy on the backend.               | To Do  |          5 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       5 |         7 |       5 | Fix CORS error on upload      | File upload requests from the frontend are being blocked by CORS policy on the backend.               | To Do  |          5 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       6 |         8 |       6 | Add dark mode toggle          | Implement a dark/light theme switcher using Tailwind CSS and persist the choice in local storage.     | To Do  |          6 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       7 |         2 |       7 | Refactor auth middleware      | Clean up JWT verification logic and separate it from the route handlers for reusability.              | To Do  |          7 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       7 |         1 |       7 | Refactor auth middleware      | Clean up JWT verification logic and separate it from the route handlers for reusability.              | To Do  |          7 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       8 |         3 |       8 | Deploy staging environment    | Set up a staging server on Render separate from production for QA testing.                            | To Do  |          8 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       8 |         4 |       8 | Deploy staging environment    | Set up a staging server on Render separate from production for QA testing.                            | To Do  |          8 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       9 |         5 |       9 | Fix mobile responsive layout  | Sidebar overlaps main content on screens smaller than 768px width.                                    | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      10 |         5 |      10 | Update password hashing       | Migrate password storage from plain crypt to bcrypt for stronger security.                            | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      10 |         7 |      10 | Update password hashing       | Migrate password storage from plain crypt to bcrypt for stronger security.                            | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      11 |         4 |      11 | Implement rate limiting       | Add request rate limiting on public API routes to prevent abuse and brute force attempts.             | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      12 |         1 |      12 | Fix memory leak in worker     | Background job worker memory usage grows steadily over 24 hours and eventually crashes.               | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      12 |         2 |      12 | Fix memory leak in worker     | Background job worker memory usage grows steadily over 24 hours and eventually crashes.               | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      13 |         2 |      13 | Add unit tests for auth       | Write Jest test coverage for login, register, and token refresh flows.                                | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      14 |         5 |      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      14 |         6 |      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      14 |         1 |      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      15 |         8 |      15 | Set up error monitoring       | Integrate Sentry to track and alert on unhandled exceptions in production.                            | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      16 |         6 |      16 | Fix pagination bug            | Task list pagination skips records when items are deleted between page loads.                         | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      17 |         3 |      17 | Add email notifications       | Send an email when a user is assigned to a new task using Nodemailer.                                 | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      17 |         5 |      17 | Add email notifications       | Send an email when a user is assigned to a new task using Nodemailer.                                 | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      18 |         1 |      18 | Improve error messages        | Replace generic 500 errors with descriptive messages for common validation failures.                  | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      19 |         8 |      19 | Set up database backups       | Configure automated daily backups for the production PostgreSQL database.                             | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      20 |         3 |      20 | Fix duplicate task creation   | Double-clicking submit button creates two identical tasks due to missing debounce.                    | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      21 |         6 |      21 | Add search functionality      | Implement full text search on task title and description fields.                                      | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      21 |         5 |      21 | Add search functionality      | Implement full text search on task title and description fields.                                      | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      22 |         7 |      22 | Review and rotate secrets     | Old API keys and JWT secrets committed to git history need to be rotated.                             | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      22 |         4 |      22 | Review and rotate secrets     | Old API keys and JWT secrets committed to git history need to be rotated.                             | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      23 |         1 |      23 | Add role based access control | Restrict admin only routes like user management to users with role = admin.                           | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      24 |         6 |      24 | Fix timezone display bug      | Due dates show in UTC instead of the logged in user local timezone.                                   | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      25 |         7 |      25 | Set up load testing           | Use k6 or Artillery to test API performance under concurrent user load.                               | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      25 |         3 |      25 | Set up load testing           | Use k6 or Artillery to test API performance under concurrent user load.                               | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      26 |         2 |      26 | Add task comments feature     | Allow users to leave comments on a task for team discussion and updates.                              | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      27 |         5 |      27 | Fix broken image uploads      | Profile picture uploads over 2MB fail silently without showing an error to the user.                  | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      27 |         1 |      27 | Fix broken image uploads      | Profile picture uploads over 2MB fail silently without showing an error to the user.                  | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      28 |         3 |      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      28 |         7 |      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      28 |         2 |      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      29 |         4 |      29 | Add dark mode for mobile app  | Extend the existing dark mode toggle to the React Native mobile client.                               | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      30 |         5 |      30 | Improve query caching         | Add Redis caching layer for frequently accessed task list queries.                                    | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      30 |         2 |      30 | Improve query caching         | Add Redis caching layer for frequently accessed task list queries.                                    | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--(49 rows)

SELECT * FROM task_assignees JOIN tasks ON task_assignees.task_id = tasks.task_id ORDER BY task_assignees.assignees;

-- task_id | assignees | task_id |             title             |                                              description                                              | status | created_by |         created_at         |         updated_at
-----------+-----------+---------+-------------------------------+-------------------------------------------------------------------------------------------------------+--------+------------+----------------------------+----------------------------
--       1 |         1 |       1 | Fix login bug                 | Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling. | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       3 |         1 |       3 | Optimize DB queries           | Task list endpoint is slow with 1000+ rows. Add indexes and review N+1 query issues.                  | To Do  |          2 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       7 |         1 |       7 | Refactor auth middleware      | Clean up JWT verification logic and separate it from the route handlers for reusability.              | To Do  |          7 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      12 |         1 |      12 | Fix memory leak in worker     | Background job worker memory usage grows steadily over 24 hours and eventually crashes.               | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      14 |         1 |      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      18 |         1 |      18 | Improve error messages        | Replace generic 500 errors with descriptive messages for common validation failures.                  | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      23 |         1 |      23 | Add role based access control | Restrict admin only routes like user management to users with role = admin.                           | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      27 |         1 |      27 | Fix broken image uploads      | Profile picture uploads over 2MB fail silently without showing an error to the user.                  | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       5 |         2 |       5 | Fix CORS error on upload      | File upload requests from the frontend are being blocked by CORS policy on the backend.               | To Do  |          5 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      13 |         2 |      13 | Add unit tests for auth       | Write Jest test coverage for login, register, and token refresh flows.                                | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      30 |         2 |      30 | Improve query caching         | Add Redis caching layer for frequently accessed task list queries.                                    | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      12 |         2 |      12 | Fix memory leak in worker     | Background job worker memory usage grows steadily over 24 hours and eventually crashes.               | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      26 |         2 |      26 | Add task comments feature     | Allow users to leave comments on a task for team discussion and updates.                              | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      28 |         2 |      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       7 |         2 |       7 | Refactor auth middleware      | Clean up JWT verification logic and separate it from the route handlers for reusability.              | To Do  |          7 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      25 |         3 |      25 | Set up load testing           | Use k6 or Artillery to test API performance under concurrent user load.                               | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      28 |         3 |      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      20 |         3 |      20 | Fix duplicate task creation   | Double-clicking submit button creates two identical tasks due to missing debounce.                    | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       8 |         3 |       8 | Deploy staging environment    | Set up a staging server on Render separate from production for QA testing.                            | To Do  |          8 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       2 |         3 |       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      17 |         3 |      17 | Add email notifications       | Send an email when a user is assigned to a new task using Nodemailer.                                 | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       4 |         4 |       4 | Write API documentation       | Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.                      | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       8 |         4 |       8 | Deploy staging environment    | Set up a staging server on Render separate from production for QA testing.                            | To Do  |          8 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       1 |         4 |       1 | Fix login bug                 | Users are getting logged out randomly after 5 minutes of inactivity. Investigate JWT expiry handling. | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      22 |         4 |      22 | Review and rotate secrets     | Old API keys and JWT secrets committed to git history need to be rotated.                             | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      29 |         4 |      29 | Add dark mode for mobile app  | Extend the existing dark mode toggle to the React Native mobile client.                               | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      11 |         4 |      11 | Implement rate limiting       | Add request rate limiting on public API routes to prevent abuse and brute force attempts.             | To Do  |          4 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       4 |         5 |       4 | Write API documentation       | Document all REST endpoints for the task manager API using Swagger/OpenAPI spec.                      | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       9 |         5 |       9 | Fix mobile responsive layout  | Sidebar overlaps main content on screens smaller than 768px width.                                    | To Do  |          3 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      10 |         5 |      10 | Update password hashing       | Migrate password storage from plain crypt to bcrypt for stronger security.                            | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      14 |         5 |      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      17 |         5 |      17 | Add email notifications       | Send an email when a user is assigned to a new task using Nodemailer.                                 | To Do  |          6 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      21 |         5 |      21 | Add search functionality      | Implement full text search on task title and description fields.                                      | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      30 |         5 |      30 | Improve query caching         | Add Redis caching layer for frequently accessed task list queries.                                    | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      27 |         5 |      27 | Fix broken image uploads      | Profile picture uploads over 2MB fail silently without showing an error to the user.                  | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       2 |         5 |       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      21 |         6 |      21 | Add search functionality      | Implement full text search on task title and description fields.                                      | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      14 |         6 |      14 | Migrate to TypeScript         | Convert remaining JS files in the backend to TypeScript for better type safety.                       | To Do  |          3 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      24 |         6 |      24 | Fix timezone display bug      | Due dates show in UTC instead of the logged in user local timezone.                                   | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      16 |         6 |      16 | Fix pagination bug            | Task list pagination skips records when items are deleted between page loads.                         | To Do  |          5 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      10 |         7 |      10 | Update password hashing       | Migrate password storage from plain crypt to bcrypt for stronger security.                            | To Do  |          1 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      25 |         7 |      25 | Set up load testing           | Use k6 or Artillery to test API performance under concurrent user load.                               | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      28 |         7 |      28 | Audit npm dependencies        | Run npm audit and update packages with known security vulnerabilities.                                | To Do  |          2 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       5 |         7 |       5 | Fix CORS error on upload      | File upload requests from the frontend are being blocked by CORS policy on the backend.               | To Do  |          5 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      22 |         7 |      22 | Review and rotate secrets     | Old API keys and JWT secrets committed to git history need to be rotated.                             | To Do  |          7 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--      15 |         8 |      15 | Set up error monitoring       | Integrate Sentry to track and alert on unhandled exceptions in production.                            | To Do  |          8 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--       6 |         8 |       6 | Add dark mode toggle          | Implement a dark/light theme switcher using Tailwind CSS and persist the choice in local storage.     | To Do  |          6 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--       2 |         8 |       2 | Set up CI pipeline            | Configure GitHub Actions to run lint and tests automatically on every pull request.                   | To Do  |          4 | 2026-07-02 09:27:56.562681 | 2026-07-02 09:27:56.562681
--      19 |         8 |      19 | Set up database backups       | Configure automated daily backups for the production PostgreSQL database.                             | To Do  |          1 | 2026-07-02 09:41:11.577558 | 2026-07-02 09:41:11.577558
--(49 rows)

SELECT tasks.task_id,creators.name AS creator,tasks.title,task_assignees.assignees AS assignee_ID,users.name AS assignee_name FROM users JOIN task_assignees ON users.user_id = task_assignees.assignees 
JOIN tasks on task_assignees.task_id = tasks.task_id 
JOIN users as creators ON creators.user_id=tasks.created_by 
ORDER BY tasks.task_id;
-- task_id |      creator       |             title             | assignee_id |   assignee_name
---------+--------------------+-------------------------------+-------------+----------------------
--       1 | Nimal Perera       | Fix login bug                 |           4 | Dasun Ekanayaka
--       1 | Nimal Perera       | Fix login bug                 |           1 | Kasun Bandara
--       2 | Dasun Ekanayaka    | Set up CI pipeline            |           8 | Pathum Dissanayaka
--       2 | Dasun Ekanayaka    | Set up CI pipeline            |           3 | Nimal Perera
--       2 | Dasun Ekanayaka    | Set up CI pipeline            |           5 | Akash Kumara
--       3 | Amal Basnayaka     | Optimize DB queries           |           1 | Kasun Bandara
--       4 | Kasun Bandara      | Write API documentation       |           4 | Dasun Ekanayaka
--       4 | Kasun Bandara      | Write API documentation       |           5 | Akash Kumara
--       5 | Akash Kumara       | Fix CORS error on upload      |           7 | Ravindu Tharanga
--       5 | Akash Kumara       | Fix CORS error on upload      |           2 | Amal Basnayaka
--       6 | Chamath Abeykoon   | Add dark mode toggle          |           8 | Pathum Dissanayaka
--       7 | Ravindu Tharanga   | Refactor auth middleware      |           1 | Kasun Bandara
--       7 | Ravindu Tharanga   | Refactor auth middleware      |           2 | Amal Basnayaka
--       8 | Pathum Dissanayaka | Deploy staging environment    |           3 | Nimal Perera
--       8 | Pathum Dissanayaka | Deploy staging environment    |           4 | Dasun Ekanayaka
--       9 | Nimal Perera       | Fix mobile responsive layout  |           5 | Akash Kumara
--      10 | Kasun Bandara      | Update password hashing       |           7 | Ravindu Tharanga
--      10 | Kasun Bandara      | Update password hashing       |           5 | Akash Kumara
--      11 | Dasun Ekanayaka    | Implement rate limiting       |           4 | Dasun Ekanayaka
--      12 | Ravindu Tharanga   | Fix memory leak in worker     |           2 | Amal Basnayaka
--      12 | Ravindu Tharanga   | Fix memory leak in worker     |           1 | Kasun Bandara
--      13 | Akash Kumara       | Add unit tests for auth       |           2 | Amal Basnayaka
--      14 | Nimal Perera       | Migrate to TypeScript         |           5 | Akash Kumara
--      14 | Nimal Perera       | Migrate to TypeScript         |           1 | Kasun Bandara
--      14 | Nimal Perera       | Migrate to TypeScript         |           6 | Chamath Abeykoon
--      15 | Pathum Dissanayaka | Set up error monitoring       |           8 | Pathum Dissanayaka
--      16 | Akash Kumara       | Fix pagination bug            |           6 | Chamath Abeykoon
--      17 | Chamath Abeykoon   | Add email notifications       |           3 | Nimal Perera
--      17 | Chamath Abeykoon   | Add email notifications       |           5 | Akash Kumara
--      18 | Dasun Ekanayaka    | Improve error messages        |           1 | Kasun Bandara
--      19 | Kasun Bandara      | Set up database backups       |           8 | Pathum Dissanayaka
--      20 | Nimal Perera       | Fix duplicate task creation   |           3 | Nimal Perera
--      21 | Amal Basnayaka     | Add search functionality      |           6 | Chamath Abeykoon
--      21 | Amal Basnayaka     | Add search functionality      |           5 | Akash Kumara
--      22 | Ravindu Tharanga   | Review and rotate secrets     |           4 | Dasun Ekanayaka
--      22 | Ravindu Tharanga   | Review and rotate secrets     |           7 | Ravindu Tharanga
--      23 | Chamath Abeykoon   | Add role based access control |           1 | Kasun Bandara
--      24 | Ravindu Tharanga   | Fix timezone display bug      |           6 | Chamath Abeykoon
--      25 | Pathum Dissanayaka | Set up load testing           |           3 | Nimal Perera
--      25 | Pathum Dissanayaka | Set up load testing           |           7 | Ravindu Tharanga
--      26 | Dasun Ekanayaka    | Add task comments feature     |           2 | Amal Basnayaka
--      27 | Akash Kumara       | Fix broken image uploads      |           1 | Kasun Bandara
--      27 | Akash Kumara       | Fix broken image uploads      |           5 | Akash Kumara
--      28 | Amal Basnayaka     | Audit npm dependencies        |           3 | Nimal Perera
--      28 | Amal Basnayaka     | Audit npm dependencies        |           7 | Ravindu Tharanga
--      28 | Amal Basnayaka     | Audit npm dependencies        |           2 | Amal Basnayaka
--      29 | Nimal Perera       | Add dark mode for mobile app  |           4 | Dasun Ekanayaka
--      30 | Kasun Bandara      | Improve query caching         |           5 | Akash Kumara
--      30 | Kasun Bandara      | Improve query caching         |           2 | Amal Basnayaka
--(49 rows)

SELECT status, COUNT(*) AS total_count FROM tasks GROUP BY status ORDER BY total_count DESC;

--   status    | total_count
---------------+-------------
-- To Do       |          18
-- Done        |           6
-- In Progress |           6
--(3 rows)

SELECT users.name AS assignee_name , COUNT(*) AS no_of_tasks FROM task_assignees 
JOIN users ON task_assignees.assignees = users.user_id 
GROUP BY assignee_name 
ORDER BY no_of_tasks ASC;

--   assignee_name    | no_of_tasks
----------------------+-------------
-- Chamath Abeykoon   |           4
-- Pathum Dissanayaka |           4
-- Ravindu Tharanga   |           5
-- Nimal Perera       |           6
-- Dasun Ekanayaka    |           6
-- Amal Basnayaka     |           7
-- Kasun Bandara      |           8
-- Akash Kumara       |           9
--(8 rows)

CREATE INDEX idx_tasks_created_by ON tasks(created_by);
--CREATE INDEX

CREATE INDEX idx_tasks_status ON tasks(status);
--CREATE INDEX

CREATE INDEX idx_task_assignees_assignees ON task_assignees(assignees);
--CREATE INDEX

 EXPLAIN SELECT * FROM tasks WHERE tasks.created_by = 4;

--                      QUERY PLAN
---------------------------------------------------------
-- Seq Scan on tasks  (cost=0.00..2.54 rows=5 width=135)
--   Filter: (created_by = 4)
--(2 rows)

SET enable_seqscan = OFF;
--SET

EXPLAIN SELECT * FROM tasks WHERE tasks.created_by = 4;

--                                    QUERY PLAN
-------------------------------------------------------------------------------------
-- Bitmap Heap Scan on tasks  (cost=4.18..6.24 rows=5 width=135)
--   Recheck Cond: (created_by = 4)
--   ->  Bitmap Index Scan on idx_tasks_created_by  (cost=0.00..4.18 rows=5 width=0)
--         Index Cond: (created_by = 4)
--(4 rows)


##What the index did?

--index helps to find matching rows without checking every row in the table 