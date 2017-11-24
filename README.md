![Slackproval](https://i.imgur.com/k78sOmi.png)

The lightweight slack approved system for managing invites to an open slack community

![](https://i.imgur.com/RPrOmu1.png)

## What makes Slackproval different?
Other slack auto-invite systems can cause issues by automatically allowing scammers/phishers/spammers to join your open slack community. Slackproval is an open source solution that gives the admins of the community power to moderate their incoming new users.

## Features
- Approve or deny applicants
- Blacklist domains/emails/IPs from being able to request access
- Configurable required reason for joining
- Customizable name and logo
- Configurable Code of Conduct agreement
- Anti bot measures
- Audit log for requests

## How to set up
### Requirements
- Postgres
- Ruby/Rails
### Configuration
Environment Variables:

*Required*

- `SLACK_API_TOKEN` - Slack API token for authentication. Must be the legacy api token found [here](https://api.slack.com/custom-integrations/legacy-tokens)
- `SLACK_SUBDOMAIN` - Slack subdomain (ex: `example` in https://example.slack.com)
- `DATABASE_URL` - Set the url for the database (default: localhost)
  - On heroku, this includes the username and password for the database
- `SLACK_NAME` Name of your slack
- `SLACK_ICON` URL to your slack icon
- `DEFAULT_ADMIN_EMAIL` - Email of the default admin, when they register they will automatically be given the admin role
- `ADMIN_PASSWORD` - Password to get to the user sign up page

*Optional*

- `DATABASE_USER` - Set the user for the database
- `DATABASE` - Name of the database
- `DATABASE_PASSWORD` - Password to the database user
- `DB_POOL` - Amount of database pool (default: 25)
- `ADMIN_USERNAME` - Username to get to the user sign up page (default `admin`)
- `REQUIRE_REASON` - Whether or not your requesting users need to provide a reason for joining (default: true)

## How to use
### First time launching
- After launching the application on your choice hosting service, make sure you configure the application with the above environment variables.
- Go to https://your_url_here/signup and enter the `ADMIN_USERNAME` and `ADMIN_PASSWORD` and sign up with your `DEFAULT_ADMIN_EMAIL`
- Go to https://your_url_here/login to access your account
- Start approving users!
### Approval process
- An end user will go through the requesting access process, and then the requests will show up in the "Requests" tab
- <img src="https://i.imgur.com/UquEppG.png" alt="green checkmark" width="20" height="20"> means that the requesting user is approved and will receive a slack invite
- <img src="https://imgur.com/XJF8jAj.png" alt="yellow X" width="20" height="20"> means that the requesting user is rejected (NOTE: rejected users cannot request access again with the same email)
- <img src="https://imgur.com/Hy9cTVK.png" alt="red trashcan" width="20" height="20"> means that the request is deleted, this allows the requesting user to request again with the same email
- The `New` tab contains all requests that haven't received a response
- The `Approved` tab contains all requests that have been approved
- The `Denied` tab contains all requests that have been denied
### User management
- `Admin` allows the user to show/edit/destroy any user on Slackproval
- Regular users can approve/deny/destroy requests and see a list of all users that have registered

## Developing
Options:
- `MOCK_INVITE` - Environment Variable, set to `true` to not actually send out slack email invites
Helpful:
- `rake fake:requests` - Generates 100 fake requests

## Credits
Developed by [Michael](https://github.com/mikestephens) and [Yash](https://github.com/YashdalfTheGray)

Logo created by logomakr.com
