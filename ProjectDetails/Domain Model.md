# Domain Model, ROBOFLEET.



## Domain Objects : 
- User ( ADMIN + OPERATORS )
- Robot
- Mission
- MissionLog

## Domains Rules 
User : 
- A User can either be the ADMIN or an OPERATOR
- The ADMIN has access to every Robot, Operator, Mission and MissionLog data, except sensitive personal data like Operators passwords. 
- He can delete, create and update Operators, Robots, Missions but he can't infer on MissionLog. 
- The OPERAYOR is allowed to create Missions and manage their states.

Robot : 
- Has a name, a staus, and may execute a mission, adn is created by a User, only Admins can do that. 
- The status of the robot changes depending on a random countdown
- He can only execute one mission at a time and can't execute in state of ERROR.

Mission : 
- Belongs to one Robot only. 
- Starts as pending
- Transitions allowed : PENDING -> RUNNING -> COMPLETED / FAILED

MissionLog :
- Is tied to one Mission
- Changes each minute
- Cannot be modified 
