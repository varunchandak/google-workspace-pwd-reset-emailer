# Password Reset Script

This script is used to automate the process of resetting passwords for users in a Google Workspace domain. It generates a random password for each user, updates their password in the Google Admin Directory, and sends an email notification with the new password.

## Prerequisites

Before running the script, ensure that you have the following:

- Bash shell environment
- OpenSSL installed
- `sendemail` command-line tool installed
- Access to the Google Admin Directory API
- Amazon SES (Simple Email Service) credentials for sending emails

## Configuration

1. Open the script file `password-reset.sh` and make the following modifications:

   - Set the `DOMAIN` variable to your domain name (e.g., `example.com`).
   - Set the `FROM_EMAIL` variable to the email address from which the password reset emails will be sent.
   - Replace `password-reset-email.html` with the file path of your HTML email template.

2. Create a CSV file named `gws-users.csv` and populate it with the email addresses of the users for whom you want to reset passwords.

3. Ensure you have the necessary permissions and access token to execute the script.

## Usage

1. Open a terminal and navigate to the directory where the script is located.

2. Run the following command to make the script executable:

   ```shell
   chmod +x password-reset.sh
   ```

3. Execute the script by running the following command:

   ```shell
   ./password-reset.sh
   ```

4. When prompted, enter the OAuth token for accessing the Google Admin Directory API.

5. The script will iterate through each email address in the `gws-users.csv` file, generate a random password, update the user's password in the Google Admin Directory, and send a password reset email.

6. Wait for a few seconds between each iteration to avoid overwhelming the email service.

## HTML Email Template

The script uses an HTML email template (`password-reset-email.html`) to format the password reset email. You can customize this template as per your requirements. The template currently includes the placeholder `XXXXXXXXXXXXX`, which will be replaced with the randomly generated password for each user.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to create a pull request or submit an issue.

## License

This script is licensed under the [MIT License](LICENSE).
